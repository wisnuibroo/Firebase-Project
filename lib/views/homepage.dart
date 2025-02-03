import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_project/controller/homecontroller.dart';
import 'package:firebase_project/views/profilepage.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  bool isFirstVisit = true;

  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: MyText(
          text: docID == null ? 'Add Name' : 'Update Name',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Siapa namamu...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  textController.clear();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: MyText(
                    text: "Cancel",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  if (docID == null) {
                    firestoreService.addNote(textController.text);
                  } else {
                    firestoreService.UpdateNote(docID, textController.text);
                  }

                  textController.clear();
                  setState(() {
                    isFirstVisit = false;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: MyText(
                    text: "Save",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

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
        backgroundColor: Colors.white,
      ),
      drawer: _buildDrawer(user),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        backgroundColor: Color(0xFF7F70DF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFirstVisit)
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFB3A7FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.network(
                      'https://img.pikbest.com/element_our/20220729/bg/5a04f92464359.png!w700wp',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyText(
                        text: 'Absen dulu dong!',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getNotesStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List notesList = snapshot.data!.docs;
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = notesList[index];
                        String docID = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String noteText = data['note'];

                        return _buildNoteCard(noteText, docID);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No notes yet. Start adding some!"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(User? user) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? 'Guest'),
            accountEmail: Text(user?.email ?? 'Guest'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
            ),
          ),
          ListTile(
            title: MyText(
              text: "Profile",
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            leading: const Icon(Icons.person),
            onTap: () {
              Get.to(
                () => ProfilePage(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 350),
              );
            },
          ),
          ListTile(
            title: MyText(
              text: 'Log Out',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            leading: const Icon(Icons.logout),
            onTap: () {
              Get.toNamed("/login");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(String noteText, String docID) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        title: MyText(
          text: noteText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => openNoteBox(docID: docID),
              icon: const Icon(Icons.edit, color: Color(0xFF7F70DF)),
            ),
            IconButton(
              onPressed: () => firestoreService.deleteNote(docID),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
