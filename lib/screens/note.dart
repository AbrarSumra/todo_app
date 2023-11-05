class Note {
  Note(
    this.title,
    this.description,
    this.time,
    this.date,
  );
  final String title;
  final String description;
  final String time;
  DateTime date = DateTime.now();
}
