import 'package:flutter/cupertino.dart';
import 'package:plnr_api_integration_pagination/repository/api_repo.dart';

import '../models/user_data.dart';
import '../utils/api_response.dart';

class ApiProvider extends ChangeNotifier {
  ApiProvider({required this.apiRepo});

  ApiRepo apiRepo;
  List<Datum> data = [];
  late int page;
  late int totalPages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _firstLoading = true;
  bool get firstLoading => _firstLoading;

  Future<void> getUserData({required int pageNumber}) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await apiRepo.getUserData(pageNumber: pageNumber);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      //  print(apiResponse.response!.data);
      final userData = userDataFromJson(apiResponse.response.toString());

      data.addAll(userData.data);
      page = userData.page;
      totalPages = userData.totalPages;

      _firstLoading = false;
      _isLoading = false;
      notifyListeners();
    }
// else
// {
//     notifyListeners();

// }
  }

  void showbottomLoader() {
    _isLoading = true;
    notifyListeners();
  }
}
