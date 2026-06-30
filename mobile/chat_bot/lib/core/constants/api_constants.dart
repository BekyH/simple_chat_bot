import 'package:flutter/foundation.dart';

class ApiConstants {
  const ApiConstants._();

  static String get baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8001';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://10.0.2.2:8001';
      default:
        return 'http://127.0.0.1:8001';
    }
  }

  static const String chatPath = '/chat';
}
