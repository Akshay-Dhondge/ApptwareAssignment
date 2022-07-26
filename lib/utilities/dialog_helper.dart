import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  ///ERROR DIALOG
  static void showErrorDialog(
      {String title = 'Error',
      String description = 'Something went wrong',
      Function()? onTap}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),

              ///SPACE
              const SizedBox(
                height: 10,
              ),

              ///DESCRIPTION
              Text(
                description,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),

              ///SPACE
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      onTap != null ? onTap() : null;
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange,
                      ),
                      child: const Text(
                        "Ok",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///INFO DIALOG
  static void showInfoDialog({
    String title = "Info",
    String description = "Coming soon.",
    Function()? onTap,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),

              ///SPACE
              const SizedBox(
                height: 10,
              ),

              ///DESCRIPTION
              Text(
                description,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),

              ///SPACE
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      onTap != null ? onTap() : null;
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: const Text(
                        "Ok",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///INFO DIALOG WITH OPTIONS
  static void showDialogWithOptions({
    String title = "Info",
    String description = "Coming soon.",
    String submitBtnText = "Submit",
    String cancelBtnText = "Cancel",
    Function()? onSubmit,
    Function()? onCancel,
  }) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0)), //this right here
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    onSubmit != null ? onSubmit() : null;
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        submitBtnText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                      // color: Color(0xFFE8705A),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.orange, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        cancelBtnText,
                        style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  ///LOADING DIALOG
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                strokeWidth: 5,
              ),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  ///LOADING CIRCULAR INDICATOR
  static void showLoadingIndicator() {
    ///LOADING DIALOG OPENED
    Get.dialog(
      WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
              ),
            ),
          )),
      barrierDismissible: false,
    );
  }

  ///HIDE LOADING
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
