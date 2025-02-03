import 'package:firebase_project/controller/logincontroller.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return FlutterLogin(
      onSignup: (val) async {
        await controller.handleSignUp(val);
      },
      logo: const AssetImage("assets/murid.png"),
      title: "Absensi 11 PPLG 2",
      initialAuthMode: AuthMode.signup,
      userType: LoginUserType.email,
      onLogin: (val) async {
        await controller.handleLogin(val);
      },
      onRecoverPassword: (val) async {
        await controller.handlePasswordRecovery(val);
      },
      headerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              await controller.signInWithGoogle();
            },
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png",
                    width: 25,
                  ),
                  const SizedBox(width: 10),
                  const MyText(
                    text: 
                    "Sign in with Google",
                   
                      fontSize: 14,
                      color: Colors.black54, fontWeight: FontWeight.bold,
                    
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      theme: LoginTheme(
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
