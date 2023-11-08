import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wscube_todo_app/screens/note.dart';

class NewNote extends StatefulWidget {
  /* final Note note;*/
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<Note> notes = [];
  DateTime pickedDate = DateTime.now();
  String pickedTime = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selectTime(BuildContext ctx) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        pickedTime = selectedTime.format(context);
      });
    }
  }

  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (selectedDate != null) {
      setState(() {
        pickedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.pin),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_alert_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.archive_outlined),
          ),
        ],
      ),
      body: SizedBox(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Title";
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 11),
                TextFormField(
                  controller: _noteController,
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Note";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Type somethings here...",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    TextButton(
                      child: const Text(
                        "Set Time",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () => _selectTime(context),
                    ),
                    Text(pickedTime),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      child: const Text(
                        "Set Date",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () => _selectDate(context),
                    ),
                    Text("${pickedDate.toLocal()}".split(" ")[0])
                  ],
                ),
                const SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final singleNote = Note(
                          title: _titleController.text,
                          description: _noteController.text,
                          time: pickedTime,
                          date: pickedDate,
                        );
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, singleNote);

                          notes.add(singleNote);
                        }
                        setState(() {});

                        _titleController.clear();
                        _noteController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
