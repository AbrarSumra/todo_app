import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  AppDataBase._();

  static final AppDataBase instance = AppDataBase._();

  Database? myDb;

  Future<Database> getDB() async {
    if (myDb != null) {
      return myDb!;
    } else {
      var data = await initDB();
      return data;
    }
  }

  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(docDirectory.path, "noteDb.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        db.execute(
            "create table notes ( noteId integer primary key autoincriment, title text, desc text )");
      },
    );
  }

  void addNote(String mTitle, mDesc) async {
    var db = await getDB();
    db.insert("notes", {
      "title": mTitle,
      "desc": mDesc,
    });
  }

  Future<List<Map<String, dynamic>>> fetchNotes() async {
    var db = await getDB();
    var appData = db.query("notes");
    return appData;
  }
}
