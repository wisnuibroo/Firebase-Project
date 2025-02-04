import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CRUDcontroller extends GetxController {
  final CollectionReference notes = 
      FirebaseFirestore.instance.collection('notes');

  // CREATE
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ
  Stream<QuerySnapshot> getNotesStream() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }

  // UPDATE
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

 // DELETE
  Future<void> deleteNote(String docID, BuildContext context) async {
    // Menampilkan dialog konfirmasi
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apakah kamu yakin?'),
        content: Text('Setelah dihapus, data ini tidak bisa dikembalikan.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);  
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);  
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      // Jika konfirmasi maka lanjutkan untuk menghapus
      await notes.doc(docID).delete();

      Get.snackbar(
        'Berhasil',
        'Data berhasil dihapus!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color.fromARGB(0, 30, 255, 0),
        colorText: Colors.black,
        duration: Duration(seconds: 2),
      );
    }
  }
}
