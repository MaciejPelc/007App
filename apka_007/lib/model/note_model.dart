class NoteModel {
  String? place;
  int? id;
  String title;
  String body;
  DateTime? creation_date;

  NoteModel(
      {this.id,
      required this.title,
      required this.body,
      this.creation_date,
      this.place});

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creation_date": creation_date.toString(),
      "place": place,
    });
  }
}
