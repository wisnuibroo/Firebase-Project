import 'package:firebase_project/controller/logincontroller.dart';
import 'package:get/get.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller login here
    Get.put(LoginController());
  }
}
