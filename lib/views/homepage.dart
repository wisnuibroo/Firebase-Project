import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome HomePage",
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(accountName: Text(
              user?.displayName ?? 'Guest',
            ),
             accountEmail: Text(
              user?.email ?? 'Guest',
             ),
             currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? "",
             )
             ),
             ),
            ListTile(
              title: Text("profile"),
              onTap: () {},
            ),
            ListTile(
              title: Text("setting"),
              onTap: () {},
            ),
            ListTile(
              title: Text("log out"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}