import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/ItemModel.dart';

class NewsDbProvider {
  Database db;

  // Class constructors can't have async methods, so we give them initialization
  // methods

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    //Dart doesn't have an openOrCreate database, openDatabase handles
    // all conditions,

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""CREATE TABLE Items
      (
      id INTEGER PRIMARY KEY,
      type TEXT,
      by TEXT,
      time INTEGER,
      text TEXT,
      parent INTEGER,
      kids BLOB,
      dead INTEGER,
      deleted INTEGER,
      url TEXT,
      score INTEGER,
      title TEXT,
      descendants INTEGER
      )
    """);
    });
  }

  Future<ItemModel>fetchItem(int id) async {
    //Flutter has its own methods for querying conditions!

    //Maps in Dart are like javascript objects

    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int>addItem(ItemModel item) {
    db.insert("Items", item.toMapForDb());
  }
}
