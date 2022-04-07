import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../db/database_provider.dart';
import '../model/note_model.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context)?.settings.arguments as NoteModel;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 216, 221),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Your Note"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DatabaseProvider.db.deleteNote(note.id!);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              note.place == null
                  ? Text(
                      "I do not know your place",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      note.place!,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
              Text(
                note.title,
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                note.body,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
