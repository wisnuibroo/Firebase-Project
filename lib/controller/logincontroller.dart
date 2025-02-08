import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Login Controller
class LoginController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar(
          "Sign in Cancelled",
          "You canceled the Google sign-in",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        Get.snackbar(
          "Sign in Successfully",
          "Welcome ${user.displayName ?? 'user'}!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offNamed('/home');
      }
      return user;
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("login error: $e");
      return null;
    }
  }

  Future<void> handleSignUp(SignupData signupData) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: signupData.name!,
        password: signupData.password!,
      );
      User? user = userCredential.user;

      if (user != null) {
        Get.snackbar("SignUp SUcces", "Welcome ${user.email}!");
        Get.toNamed("/home");
      }
    } catch (e) {
      Get.snackbar("SignUp SUcces", e.toString());
    }
  }

  // LOGIN
  Future<void> handleLogin(LoginData loginData) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      );
      User? user = userCredential.user;

      if (user != null) {
        Get.snackbar("Login SUcces", "Welcome Back, ${user.email}!");
        Get.toNamed("/home");
      }
    } catch (e) {
      Get.snackbar("SignUp SUcces", e.toString());
    }
  }

  // password Recovery
  Future<void> handlePasswordRecovery(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

      Get.snackbar("Password Recovery", "Password Reset email sent to $email!");
    } catch (e) {
      Get.snackbar("Password Recovery Failed", e.toString());
    }
  }

  // SIGN IN  Anonymous
  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        Get.snackbar("Anonymous Login SUcces", "Welcome Back Anonymous User!");
        Get.toNamed("/home");
      }
    } catch (e) {
      Get.snackbar("Anonymous Login Failed", e.toString());
    }
  }
}
