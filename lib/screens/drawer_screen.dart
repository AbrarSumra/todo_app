import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wscube_todo_app/constant/icon_name_button.dart';
import 'package:wscube_todo_app/screens/favorite_screen.dart';
import 'package:wscube_todo_app/screens/note.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  final List<Note> favoriteNotes = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 11),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Today Notes",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 11),
            IconNameButton(
              () {},
              iconData: Icons.tips_and_updates_outlined,
              name: "Notes",
            ),
            const SizedBox(height: 5),
            IconNameButton(
              () {},
              iconData: Icons.add_alert_outlined,
              name: "Reminders",
            ),
            const Divider(indent: 55),
            const SizedBox(height: 11),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "LABELS",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            IconNameButton(
              () {},
              iconData: Icons.add,
              name: "Create new label",
            ),
            const Divider(indent: 55),
            const SizedBox(height: 11),
            IconNameButton(
              () {},
              iconData: Icons.archive_outlined,
              name: "Archive",
            ),
            const SizedBox(height: 5),
            IconNameButton(
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => FavouriteScreen(
                              favouriteNote: favoriteNotes,
                            )));
              },
              iconData: CupertinoIcons.heart_fill,
              name: "Favorite",
            ),
            const SizedBox(height: 5),
            IconNameButton(
              () {},
              iconData: Icons.delete_outline,
              name: "Bin",
            ),
            const Divider(indent: 55),
            const SizedBox(height: 11),
            IconNameButton(
              () {},
              iconData: Icons.settings_outlined,
              name: "Settings",
            ),
            const SizedBox(height: 5),
            IconNameButton(
              () {},
              iconData: Icons.sim_card_alert_outlined,
              name: "Send app feedback",
            ),
            const SizedBox(height: 5),
            IconNameButton(
              () {},
              iconData: Icons.help_outline,
              name: "Help",
            ),
          ],
        ),
      ),
    );
  }
}
