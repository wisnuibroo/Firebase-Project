import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/controller/crudcontroller.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:firebase_project/widgets/my_text_field.dart';
import 'package:firebase_project/widgets/my_button.dart';
import 'package:firebase_project/widgets/my_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CRUDcontroller crudController = Get.find<CRUDcontroller>();

  void openNoteBox({String? docID}) {
    final TextEditingController textController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: MyText(
          text: docID == null ? 'Add Name' : 'Update Name',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        content: MyTextField(
          controller: textController,
          hintText: 'Siapa namamu...',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButton(
                text: "Cancel",
                onPressed: () {
                  textController.clear();
                  Get.back();
                },
                color: Colors.red,
              ),
              MyButton(
                text: "Save",
                onPressed: () {
                  if (docID == null) {
                    crudController.addNote(textController.text);
                  } else {
                    crudController.updateNote(docID, textController.text);
                  }
                  textController.clear();
                  Get.back();
                },
                color: Colors.green,
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
      drawer: Drawer(
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
                Get.toNamed("/profile");
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        backgroundColor: const Color(0xFF7F70DF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: crudController.getNotesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List notesList = snapshot.data!.docs;

                  // Jika tidak ada data, melihatkan pesan "Absen dulu dong!"
                  if (notesList.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB3A7FF),
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
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = notesList[index];
                        String docID = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String noteText = data['note'];

                        return MyCard(
                          text: noteText,
                          onEdit: () => openNoteBox(docID: docID),
                          onDelete: () => crudController.deleteNote(docID, context),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
