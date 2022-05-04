import 'dart:async';
import 'package:local_storage/models/fruit_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbManager {
  late Database _database;

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "ss.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE FruitModel(id INTEGER PRIMARY KEY autoincrement, fruitName TEXT, fruitQuantity TEXT)",
      );
    });
    return _database;
  }

  Future insertFruitModel(FruitModel fruitmodel) async {
    await openDb();
    return await _database.insert('Fruitmodel', fruitmodel.toJson());
  }

  Future<List<FruitModel>> getFruitModelList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('Fruitmodel');

    return List.generate(maps.length, (i) {
      return FruitModel(
          id: maps[i]['id'],
          fruitName: maps[i]['fruitName'],
          fruitQuantity: maps[i]['fruitQuantity']);
    });
    // return maps
    //     .map((e) => Model(
    //         id: e["id"], fruitName: e["fruitName"], quantity: e["quantity"]))
    //     .toList();
  }

  Future<int> updateModel(FruitModel fruitModel) async {
    await openDb();
    return await _database.update('FruitModel', fruitModel.toJson(),
        where: "id = ?", whereArgs: [fruitModel.id]);
  }

  Future<void> deleteModel(FruitModel fruitmodel) async {
    await openDb();
    await _database.delete('fruitmodel', where: "id = ?", whereArgs: [fruitmodel.id]);
  }
}
