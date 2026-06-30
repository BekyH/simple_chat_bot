import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../features/chat/data/datasources/chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/presentation/controllers/chat_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(
      DioClient.create(baseUrl: ApiConstants.baseUrl),
      permanent: true,
    );

    Get.lazyPut<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(Get.find<Dio>()),
      fenix: true,
    );

    Get.lazyPut<ChatRepository>(
      () => ChatRepositoryImpl(Get.find<ChatRemoteDataSource>()),
      fenix: true,
    );

    Get.lazyPut<SendMessageUseCase>(
      () => SendMessageUseCase(Get.find<ChatRepository>()),
      fenix: true,
    );

    Get.put<ChatController>(ChatController(Get.find<SendMessageUseCase>()));
  }
}
