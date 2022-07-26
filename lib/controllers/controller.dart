import 'dart:developer';

import 'package:assignment/constants/api_constants.dart';
import 'package:assignment/models/sample_data.dart';
import 'package:assignment/services/exception_handler.dart';
import 'package:assignment/services/service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

enum DataState { loading, complete }

class Controller extends GetxController with ExceptionHandler {
  List<User> sampleDataModel = [];
  var state = DataState.loading.obs;
  bool hasReachedEndOfResults = false;
  var errorString = '';

  Future<void> getSampleData({required int pageNumber, int limit = 10}) async {
    await BaseClient(
            url:
                '${ApiConstants.baseUrl}${ApiConstants.getUsers}page=$pageNumber&limit=$limit')
        .get()
        .then(
      (value) {
        if (value == null) {
        } else {
          List<User> sampleData = [];
          List tempList = value["data"];
          tempList.forEach((element) {
            sampleData.add(User.fromJson(element));
          });
          if (sampleData.isEmpty || value["total"] == sampleData.length) {
            hasReachedEndOfResults = true;
          }
          setSampleData(sampleData: sampleData);
        }
      },
    ).catchError(
      (onError) {
        log("Get Sample Data Details $onError ${onError.message}");
        errorString = "${onError.message}";
        handleError(onError, isShowDialog: true, isShowSnackbar: false);
      },
    );

    state.value = DataState.complete;
  }

  setSampleData({required List<User> sampleData}) {
    if (sampleData.isEmpty) {
      return;
    }
    sampleDataModel = sampleData;
  }

  @override
  refresh() async {
    errorString = '';
  }
}
