import 'package:get/get.dart';
import '../controllers/oreder_controller.dart';

class OrederBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrederController>(() => OrederController());
  }
}
