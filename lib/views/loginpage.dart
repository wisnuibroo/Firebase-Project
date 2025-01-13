import 'package:firebase_project/controller/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller
    final loginController = Get.put(LoginController());

    return FlutterLogin(
      headerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              await loginController.signInWithGoogle();
            },
            child: Center(
              child: Text("Google Sign In"),
            ),
          ),
        ],
      ),
      onSignup: (val) {},
      logo: const AssetImage("assets/google.png"),
      title: "Flutter Login",
      initialAuthMode: AuthMode.signup,
      userType: LoginUserType.email,
      onLogin: (val) async {},
      onRecoverPassword: (val) async {},
      theme: LoginTheme(
        titleStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
