import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wscube_todo_app/screens/drawer_screen.dart';
import 'package:wscube_todo_app/screens/favorite_screen.dart';
import 'package:wscube_todo_app/screens/new_note.dart';
import 'package:wscube_todo_app/screens/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLight = false;
  bool isFavourite = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isLight ? Colors.black12 : Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(
                      Icons.double_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => FavouriteScreen()));
                    },
                    icon: const Icon(CupertinoIcons.star),
                  )
                  /*const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Colors.black,
                      backgroundImage: AssetImage("assets/images/hacker.png"),
                    ),
                  )*/
                ],
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: noteList.length,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  final note = noteList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const NewNote())).then((value) {
                        setState(() {});
                      });
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
                                noteList[index].title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                noteList[index].description,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${noteList[index].date.toLocal()}"
                                    .split(" ")[0],
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
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isFavourite = !isFavourite;
                                        noteList[index].isFavourite =
                                            !noteList[index].isFavourite;
                                        if (noteList[index].isFavourite) {
                                          favouriteNotes.add(noteList[index]);
                                        } else {
                                          favouriteNotes
                                              .remove(noteList[index]);
                                        }
                                      });
                                    },
                                    icon: isFavourite
                                        ? const Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Colors.red,
                                          )
                                        : const Icon(CupertinoIcons.heart),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        noteList.remove(noteList[index]);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              "Note Deleted...",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            action: SnackBarAction(
                                                label: "Undo",
                                                textColor: Colors.blue,
                                                onPressed: () {
                                                  setState(() {
                                                    noteList.add(note);
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
                                ],
                              ),
                              Text(
                                noteList[index].time,
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
            setState(() {});
          }
        },
      ),
      drawer: DrawerScreen(),
    );
  }
}
