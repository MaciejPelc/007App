import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../db/database_provider.dart';
import '../model/note_model.dart';

class AddNote extends StatefulWidget {
  AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String currentAddress = "my addres";
  Position? currentposition;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please Keep your location on.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission is denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission is denied Forever');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode},${place.country}";
      });
    } catch (e) {
      print(e);
      throw ErrorHint("error");
    }
  }

  late String title;
  String body = "";
  String place = "";
  late DateTime date;
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final placeController = TextEditingController();
  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print("note added sucesfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Add new Note"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          // ignore: prefer_ _literals_to_create_immutables
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _determinePosition();
                  if (currentposition != null) {
                    placeController.text =
                        currentposition!.latitude.toString() +
                            " " +
                            currentposition!.longitude.toString();
                  }
                });
              },
              icon: Icon(Icons.gps_fixed),
            ),
            TextField(
              controller: placeController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Your Location",
              ),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "your note",
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(
            () {
              place = placeController.text;
              title = titleController.text;
              body = bodyController.text;
              date = DateTime.now();
            },
          );
          NoteModel note = NoteModel(
              title: title, body: body, creation_date: date, place: place);
          addNote(note);

          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        label: Text("Save Note"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
