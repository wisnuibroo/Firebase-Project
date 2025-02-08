import 'package:firebase_project/controller/crudcontroller.dart';
import 'package:get/get.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller home
    Get.put(CRUDcontroller());
  }
}
