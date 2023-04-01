import 'dart:io';

import 'package:dio/dio.dart';

class DioClient {
  String baseUrl = "https://reqres.in/api/users?";
  // late LoggingInterceptor loggingInterceptor;
  late Dio dio;

  DioClient(
    this.baseUrl,
    Dio dioClient,
    // {
    // this.loggingInterceptor,
    //}
  ) {
    dio = dioClient;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 60000
      ..options.receiveTimeout = 60000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    //dio.interceptors.add(loggingInterceptor);
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    FormData? data,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
