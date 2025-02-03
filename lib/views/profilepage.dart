import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: 'Profile',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
           Get.toNamed("/home");
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                user?.photoURL ??
                    "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png", // Gambar default jika user tidak punya foto
              ),
            ),
            SizedBox(height: 20),
            MyText(
              text: user?.displayName ?? "Guest",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            SizedBox(height: 10),
            MyText(
              text: user?.email ?? "Email not available",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.toNamed("/login");
              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: MyText(
                  text: 'Log Out',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
