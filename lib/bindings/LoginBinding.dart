import 'package:firebase_project/controller/logincontroller.dart';
import 'package:get/get.dart';

class Loginbinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller login
    Get.put(LoginController());
  }
}
