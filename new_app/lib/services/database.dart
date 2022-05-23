import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final String uid;
  DataService({required this.uid});
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('Notes');

  Future createUserData(String notes, String localisation, String title) async {
    return await notesCollection.doc(uid).set({
      'notes': notes,
      'title': title,
      'localisation': localisation,
    });
  }

  Future addData(String notes, String localisation, String title) async {
    return await notesCollection.doc(uid).collection("historic").add({
      'notes': notes,
      'title': title,
      'localisation': localisation,
    });
  }
}
