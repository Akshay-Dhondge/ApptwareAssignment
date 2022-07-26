import 'package:connectivity/connectivity.dart';
import 'dart:io';

class InternetConnectivity {
  static Future<bool> isInternetAvailable = checkInternetAvailability();

  static Future<bool> checkInternetAvailability() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      return false;
    }
    return false;
  }

  Future<bool> isInternetConnectivityAvailable() async {
    Future<bool> isInternetAvailable = checkInternetAvailability();
    return isInternetAvailable;
  }
}
