import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppToast {
  static void snackBar(String type, String message) async {
    Get.snackbar(type, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white));
  }

  static void showError(String? message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message ?? '',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showWarning(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.yellow,
        textColor: Colors.black87,
        fontSize: 16.0);
  }

  static void showSuccess(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
