import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/usecases/send_message_usecase.dart';

class ChatController extends GetxController {
  ChatController(this._sendMessageUseCase);

  final SendMessageUseCase _sendMessageUseCase;

  final TextEditingController textController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isSending = false.obs;

  Future<void> sendMessage() async {
    final rawMessage = textController.text.trim();
    if (rawMessage.isEmpty || isSending.value) {
      return;
    }

    final userMessage = ChatMessage(
      text: rawMessage,
      isUser: true,
      timestamp: DateTime.now(),
    );

    messages.add(userMessage);
    textController.clear();
    isSending.value = true;

    try {
      final reply = await _sendMessageUseCase.call(rawMessage);
      messages.add(
        ChatMessage(
          text: reply.isNotEmpty ? reply : 'No response from bot.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    } catch (error) {
      messages.add(
        ChatMessage(
          text: _mapErrorToText(error),
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    } finally {
      isSending.value = false;
    }
  }

  String _mapErrorToText(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map<String, dynamic>) {
        final detail = responseData['detail'];
        if (detail is String && detail.isNotEmpty) {
          return detail;
        }
      }

      return 'Could not reach server (${error.type.name}).';
    }

    return 'Something went wrong. Please try again.';
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
