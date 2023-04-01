import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // package:systa_integrate_ecommerce("--> ${options.method} ${options.path}");
    // package:systa_integrate_ecommerce("Headers: ${options.headers.toString()}");
    // package:systa_integrate_ecommerce("<-- END HTTP");

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // package:systa_integrate_ecommerce(
    //     "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");

    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        // package:systa_integrate_ecommerce(
        //     responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      // print(response.data);
    }

    // print("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.requestOptions?.path}");
    return super.onError(err, handler);
  }
}
