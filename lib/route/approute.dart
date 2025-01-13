import 'package:firebase_project/views/homepage.dart';
import 'package:firebase_project/views/loginpage.dart';
import 'package:get/get.dart';

class AppRoute {
  static const loginpage = '/';
  static const homepage = '/home';

  static final route = [
    GetPage(
      name: loginpage,
      page: () => LoginPage(),
      ),
    GetPage(
      name: homepage,
      page: () => HomePage()
      ),
  ];
}