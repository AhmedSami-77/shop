import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required String endPointUrl,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.get(endPointUrl, queryParameters: query);
  }

  static Future<Response> postData({
    required String endPoint,
    String? lang = 'en',
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    init();
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.post(endPoint, queryParameters: query, data: data);
  }
}
