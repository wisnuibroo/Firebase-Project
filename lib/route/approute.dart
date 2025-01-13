import 'package:firebase_project/bindings/AllBinding.dart';
import 'package:firebase_project/views/homepage.dart';
import 'package:firebase_project/views/loginpage.dart';
import 'package:get/get.dart';

class MyappRoute {
  static const loginpage = '/';
  static const homepage = '/home';

  static final page = [
    GetPage(
        name: MyappRoute.loginpage,
        page: () => LoginPage(),
        binding: AllBindings()),
    GetPage(
        name: MyappRoute.homepage,
        page: () => HomePage(),
        binding: AllBindings()),
  ];
}
