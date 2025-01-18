import 'package:firebase_project/bindings/AllBinding.dart';
import 'package:firebase_project/views/homepage.dart';
import 'package:firebase_project/views/loginpage.dart';
import 'package:firebase_project/views/profilepage.dart';
import 'package:get/get.dart';

class MyappRoute {
  static const loginpage = '/login';
  static const homepage = '/home';
  static const profilepage = '/profile';

  static final page = [
    GetPage(
        name: MyappRoute.loginpage,
        page: () => LoginPage(),
        binding: AllBindings()),
    GetPage(
        name: MyappRoute.homepage,
        page: () => HomePage(),
        binding: AllBindings()),
    GetPage(
        name: MyappRoute.profilepage,
        page: () => ProfilePage(),
        binding: AllBindings()),
  ];
}
