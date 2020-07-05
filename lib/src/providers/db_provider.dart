import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsPath = await getApplicationDocumentsDirectory();

    final path = join(documentsPath.path, 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Scans ('
            'id INTEGER PRIMARY KEY,'
            ' tipo TEXT,'
            ' valor TEXT'
            ')');
      },
    );
  }

  createScanRaw(ScanModel entry) async {
    final Database db = await database;

    final res = await db.rawInsert("INSERT INTO Scans (id, tipo, valor) "
        "VALUES (${entry.id}, '${entry.tipo}', '${entry.valor}');");
    return res;
  }

  createScan(ScanModel entry) async {
    final Database db = await database;

    final res = await db.insert('Scans', entry.toJson());
    return res;
  }

  Future<ScanModel> getScanByID(int id) async {
    final Database db = await database;

    final res = await db.query('Scans', where: 'id= ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final Database db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final Database db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHARE tipo='$type'");
    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  Future<int> updateScan(ScanModel newValues) async {
    final Database db = await database;
    final res = await db.update('Scans', newValues.toJson(),
        where: 'id=?', whereArgs: [newValues.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final Database db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteScanAll() async {
    final Database db = await database;
    final res = await db.rawDelete("DELETE FROM Scans");
    return res;
  }
}
