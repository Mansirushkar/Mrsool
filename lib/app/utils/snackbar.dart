
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum SnackbarType { error, success, info }

void showCustomSnackbar({
  required String message,
  required SnackbarType type,
})
{
  IconData iconData;
  Color backgroundColor;

  switch (type) {
    case SnackbarType.error:
      iconData = Icons.error;
      backgroundColor = Colors.red;
      break;
    case SnackbarType.success:
      iconData = Icons.check_circle;
      backgroundColor = Colors.green;
      break;
    case SnackbarType.info:
      iconData = Icons.info;
      backgroundColor = Colors.black;
      break;
  }

  Get.snackbar(
    '',
    '',
    titleText: Text(message, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'Raleway'),),
    messageText: const SizedBox(),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    icon: Icon(
      iconData,
      color: Colors.white,
    ),
    margin:  const EdgeInsets.only(bottom: 20, left: 20, right: 20,top: 25) ,
    borderRadius: 8,
    padding: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    isDismissible: true,
  );

}

void showTopSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10, // below status bar
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.yellowAccent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
              ),
            ],
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400, ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3)).then((_) => overlayEntry.remove());
}

void showTopWarningToast( BuildContext context, String message) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.greenAccent,
      behavior: SnackBarBehavior.floating,
    ),
  );

}
