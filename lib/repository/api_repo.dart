import 'package:dio/dio.dart';
import 'package:plnr_api_integration_pagination/utils/dio_client.dart';

import '../utils/api_error_handler.dart';
import '../utils/api_response.dart';
import '../utils/app_constants.dart';

class ApiRepo {
  DioClient dioClient;
  ApiRepo({
    required this.dioClient,
  });

  Future<ApiResponse> getUserData({required int pageNumber}) async {
    try {
      final response = await dioClient
          .get(AppConstants.USER_DETAILS_URI + pageNumber.toString());
      print(response.statusCode);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
