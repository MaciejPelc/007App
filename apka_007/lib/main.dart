import 'package:cool_notepad/screens/add_note.dart';
import 'package:flutter/material.dart';
import 'db/database_provider.dart';
import 'model/note_model.dart';
import 'screens/add_note.dart';
import 'screens/display_note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/AddNote": (context) => AddNote(),
        "/ShowNote": (context) => ShowNote(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<List<Map<String, Object?>>> getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(153, 204, 203, 203),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Your Notes"),
      ),
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: getNotes(),
        builder: (context, noteData) {
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ConnectionState.done:
              {
                if (noteData.data == Null || noteData.data?.length == 0) {
                  return Center(
                    child: Text("You don't have any notes yet, create one"),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(80),
                    child: ListView.builder(
                      itemCount: noteData.data?.length,
                      itemBuilder: (context, index) {
                        String title =
                            noteData.data![index]['title'].toString();
                        String body = noteData.data![index]['body'].toString();
                        String creation_date =
                            noteData.data![index]['creation_date'].toString();
                        String id = noteData.data![index]['id'].toString();
                        String place =
                            noteData.data![index]['place'].toString();
                        return Card(
                          child: Container(
                            color: Color.fromARGB(255, 220, 216, 221),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/ShowNote",
                                  arguments: NoteModel(
                                    title: title,
                                    body: body,
                                    creation_date:
                                        DateTime.parse(creation_date),
                                    id: int.parse(id),
                                    place: place,
                                  ),
                                );
                              },
                              title: Text(title),
                              subtitle: Text(body),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          }
          return Center(
            child: Text("You don't have any notes yet, create one"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddNote");
        },
      ),
    );
  }
}
