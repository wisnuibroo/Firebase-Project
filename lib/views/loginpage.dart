import 'package:firebase_project/controller/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller
    final controller = Get.put(LoginController());

    return FlutterLogin(
      headerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              await controller.signInWithGoogle();
            },
            child: Center(
                child: Image.network(
                    width: 30,
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png")),
          ),
        ],
      ),
      onSignup: (val) async {
        await controller.handleSignUp(val);
      },
      logo: const AssetImage("assets/google.png"),
      title: "Flutter Login",
      initialAuthMode: AuthMode.signup,
      userType: LoginUserType.email,
      onLogin: (val) async {
        await controller.handleLogin(val);
      },
      onRecoverPassword: (val) async {
        await controller.handlePasswordRecovery(val);
      },
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
