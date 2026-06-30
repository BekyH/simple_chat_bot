import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<String> sendMessage(String message) async {
    final response = await _remoteDataSource.sendMessage(message);
    return response.response;
  }
}
