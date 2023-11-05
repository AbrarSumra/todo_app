import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wscube_todo_app/screens/drawer_screen.dart';
import 'package:wscube_todo_app/screens/new_note.dart';
import 'package:wscube_todo_app/screens/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> noteList = [];
  late Note _deletedNote;
  bool isLight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLight ? Colors.black12 : Colors.white,
      /*appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        title: const Text(
          "Today Note",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Switch(
            value: isLight,
            inactiveThumbColor: Colors.black,
            thumbIcon: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const Icon(Icons.nightlight);
              } else {
                return const Icon(Icons.sunny);
              }
            }),
            onChanged: (value) {
              isLight = value;
              setState(() {});
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          PopupMenuButton(
            color: Colors.blue.shade50,
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (ctx) {
              return [
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 11),
                      Text("Settings"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 11),
                      Text("Delete"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 11),
                      Text("Send"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.label_outline),
                      SizedBox(width: 11),
                      Text("Labels"),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),*/
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  const Icon(
                    CupertinoIcons.line_horizontal_3,
                    color: Colors.white,
                    size: 30,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        label: Text(
                          "Search your notes",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Switch(
                    value: isLight,
                    inactiveThumbColor: Colors.black,
                    thumbIcon: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Icon(Icons.nightlight);
                      } else {
                        return const Icon(Icons.sunny);
                      }
                    }),
                    onChanged: (value) {
                      isLight = value;
                      setState(() {});
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(maxRadius: 20),
                  )
                ],
              ),
            ),
            TextFormField(),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: noteList.length,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  final note = noteList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => const NewNote()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                note.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${note.date.toLocal()}".split(" ")[0],
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    noteList.remove(note);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          "Note Deleted...",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        backgroundColor: Colors.grey.shade400,
                                        action: SnackBarAction(
                                            label: "Undo",
                                            textColor: Colors.blue,
                                            onPressed: () {
                                              setState(() {
                                                _deletedNote = note;
                                                noteList.add(_deletedNote);
                                              });
                                            }),
                                      ),
                                    );
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                note.time,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
        onPressed: () async {
          var newNote = await Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const NewNote()));

          if (newNote != null) {
            setState(() {
              noteList.add(newNote);
            });
          }
        },
      ),
      drawer: const DrawerScreen(),
    );
  }
}