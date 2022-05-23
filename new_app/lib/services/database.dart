import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DataService {
  final String uid;
  DataService({required this.uid});
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('Notes');

  Future createUserData(String notes, String localisation, String title) async {
    final id = Uuid().v1();
    return await notesCollection.doc(id).set({
      'id': id,
      'uid': uid,
      'notes': notes,
      'title': title,
      'localisation': localisation,
      'createDate': DateTime.now(),
    });
  }

  Future addData(String notes, String localisation, String title) async {
    final id = Uuid().v1();
    return await notesCollection.doc(id).set({
      'id': id,
      'uid': uid,
      'notes': notes,
      'title': title,
      'localisation': localisation,
      'createDate': DateTime.now(),
    });
  }
}
