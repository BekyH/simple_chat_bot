import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  SendMessageUseCase(this._repository);

  final ChatRepository _repository;

  Future<String> call(String message) {
    return _repository.sendMessage(message);
  }
}
