import 'package:flutter/material.dart';

import 'note.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({
    super.key,
  });

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Note _deletedNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: favouriteNotes.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            final note = favouriteNotes[index];
            return Container(
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
                            favouriteNotes.remove(note);
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
                                        favouriteNotes.add(_deletedNote);
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
            );
          }),
    );
  }
}
