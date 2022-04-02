import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/item.dart';

class DbHelper {
  static Future<void> _createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      price INTEGER
      )
      ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('afada.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await _createTables(database);
    });
  }

  //create new item
  static Future<int> createItem(Item item) async {
    final db = await DbHelper.db();

    int id = await db.insert('items', item.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //read all
  static Future<List<Item>> getItemList() async {
    final db = await DbHelper.db();
    var mapList = await db.query('items', orderBy: 'name');
    int count = mapList.length;
    List<Item> itemList = [];

    for (var i = 0; i < count; i++) {
      itemList.add(Item.fromMap(mapList[i]));
    }
    return itemList;
  }

  //read single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DbHelper.db();
    var item =
        await db.query('items', where: 'id=?', whereArgs: [id], limit: 1);
    return item;
  }

  //update item by id
  static Future<int> updateItem(Item item) async {
    final db = await DbHelper.db();
    final result = await db
        .update('items', item.toMap(), where: 'id=?', whereArgs: [item.id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DbHelper.db();
    try {
      await db.delete('items', where: 'id=?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Kesalahan menghapus item: $err");
    }
  }
}












































// import 'package:listing_app/models/item.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:async';
// import 'dart:io';

// class DbHelper {
//   static final DbHelper _dbHelper = DbHelper();
//   Database? _database;
//   // DbHelper._createObject();

//   Future<Database> initDb() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = directory.path + 'item.db';

//     var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);

//     return itemDatabase;
//   }

//   void _createDb(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE item (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         price INTEGER
//         )
//       ''');
//   }

//   Future<List<Map<String, dynamic>>> select() async {
//     Database db = await initDb();
//     var mapList = await db.query('item', orderBy: 'name');
//     return mapList;
//   }

//   Future<int> insert(Item object) async {
//     Database db = await initDb();
//     int count = await db.insert('item', object.toMap());
//     return count;
//   }

//   Future<int> update(Item object) async {
//     Database db = await initDb();
//     int count = await db
//         .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
//     return count;
//   }

//   Future<int> delete(int id) async {
//     Database db = await initDb();
//     int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
//     return count;
//   }

//   Future<List<Item>> getItemList() async {
//     var itemMapList = await select();
//     int count = itemMapList.length;
//     List<Item> itemList = <Item>[];
//     for (int i = 0; i < count; i++) {
//       itemList.add(Item.fromMap(itemMapList[i]));
//     }
//     return itemList;
//   }

//   factory DbHelper() {
//     _dbHelper;

//     return _dbHelper;
//   }

//   Future<Database?> get database async {
//     _database ??= await initDb();
//     return _database;
//   }
// }
