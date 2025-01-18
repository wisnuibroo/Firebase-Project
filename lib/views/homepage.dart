import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/api/firestore.dart';
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

  void openNoteBox({String? docID}) {
    showDialog(context: context, builder: (context) => AlertDialog(
      // text user input
      content: TextField(
        controller: textController,
      ),
      actions: [
        //button to save
        ElevatedButton(onPressed: () {
          //add a new note
          if (docID == null) {
            firestoreService.addNote(textController.text);
          }

          //update an existing note
          else {
            firestoreService.UpdateNote(docID, textController.text);
          }

          //clear a text
          textController.clear();

          //close the box
          Navigator.pop(context);
        }, 
        child: Text("Add"),
          )
        ]
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
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(stream: firestoreService.getNotesStream(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          List notesList = snapshot.data!.docs;

          //mendisplay sebagai list
          return ListView.builder(
            itemCount: notesList.length,
            itemBuilder: (context, index) {
            //mendapat masing2 dokumen individu
            DocumentSnapshot document = notesList[index];
            String docID = document.id;
            //mendapat catatan dari setiap dokumen
            Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
            String noteText = data['note'];

          // mendisplay sebagai list tile
          return ListTile(
            title: Text(noteText),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //update button
                IconButton(onPressed: () => openNoteBox(docID: docID),
                icon: const Icon(Icons.edit_document)
                ),
                //delete button
                IconButton(onPressed: () => firestoreService.deleteNote(docID), icon: Icon(Icons.delete))
            ],)
              );
            }
          );
        }
        
        else {
          return const Text("No notes..");
        }
      }),
    );
  }
}
