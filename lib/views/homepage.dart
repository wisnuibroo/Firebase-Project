import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: 'Welcome!',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user?.displayName ?? 'Guest',
              ),
              accountEmail: Text(
                user?.email ?? 'Guest',
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                user?.photoURL ?? "",
              )),
            ),
            ListTile(
              title: MyText(
                  text: "Profile",
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
              onTap: () {},
            ),
            ListTile(
              title: MyText(
                text: 'Log Out',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              onTap: () {
                Get.toNamed("/login");
              },
            ),
          ],
        ),
      ),
    );
  }
}
