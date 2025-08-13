import 'dart:async';
import 'package:get/get.dart';

class OrederController extends GetxController {
  final secondsLeft = 40.obs;
  Timer? _timer;

  @override
  void onInit() {
    _startCountdown();
    super.onInit();
  }

  void _startCountdown() {
    _timer?.cancel();
    secondsLeft.value = 40;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
