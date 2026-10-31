
import 'package:dio/dio.dart';

import 'api_const.dart';

class NetworkHelper {
  static late Dio _dio;

  static void initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept-Language": "en",
        },
      ),
    );
  }

  static Future<Response> getData({
    required String path,
  }) async {
    final response = await _dio.get(path);
    return response;
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.post(
      path,
      data: body,
    );

    return response;
  }
}
