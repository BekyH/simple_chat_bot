import 'package:dio/dio.dart';

import '../models/chat_request_model.dart';
import '../models/chat_response_model.dart';

abstract class ChatRemoteDataSource {
  Future<ChatResponseModel> sendMessage(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<ChatResponseModel> sendMessage(String message) async {
    final requestModel = ChatRequestModel(message: message);

    final response = await _dio.post<dynamic>(
      '/chat',
      data: requestModel.toJson(),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Invalid response format from server.',
      );
    }

    return ChatResponseModel.fromJson(data);
  }
}
