class Note {
  Note({
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    this.isFavourite = false,
  });
  final String title;
  final String description;
  final String time;
  bool isFavourite;
  DateTime date = DateTime.now();
}
