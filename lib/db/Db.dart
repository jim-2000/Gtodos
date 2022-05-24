import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:travella/model/taskModel.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tablename = "tasks";
  // initialize db..>>>>>>>>>>>>>>>>>>>>>>>>>>>
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tablename("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "title STRING, note TEXT, date STRING,"
          "startTime STRING, endTime STRING,"
          "remind INTEGER, repeat STRING,"
          "color INTEGER, "
          "isCompleted INTEGER)",
        );
      });
    } catch (e) {
      log(e.toString());
    }
  }

  // inserting DB
  static Future<int> insert(Task task) async {
    log("Inserted function called");
    return await _db?.insert(_tablename, task.toJson()) ?? 1;
  }

  // query db and geting myu alll tasks
  static Future<List<Map<String, dynamic>>> query() async {
    log("query function called");
    return await _db!.query(_tablename);
  }

  //
  static delete(Task task) async {
    await _db!.delete(_tablename, where: 'id=?', whereArgs: [task.id]);
  }
}
