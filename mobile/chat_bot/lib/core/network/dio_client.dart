import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static Dio create({required String baseUrl}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: const {'Content-Type': 'application/json'},
      ),
    );
  }
}
