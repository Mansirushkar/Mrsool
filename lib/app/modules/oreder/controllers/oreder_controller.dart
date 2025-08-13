// oreder_controller.dart
import 'package:get/get.dart';
import 'dart:async';
import '../../../routes/app_pages.dart';

class OrederController extends GetxController {
  var countdown = 40.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        _timer?.cancel();
        navigateToHome();
      }
    });
  }

  void navigateToHome() {
    //Get.offNamed(Routes.HOME);
  }

  void onRejectPressed() {
    navigateToHome();
  }

  void onAutoAcceptPressed() {
    navigateToHome();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
