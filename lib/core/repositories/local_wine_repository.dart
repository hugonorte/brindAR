import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:brindar/core/models/wine.dart';
import 'package:brindar/core/repositories/wine_repository.dart';

/// MVP implementation of [WineRepository] using SQLite (sqflite).
/// Replace this with [RemoteWineRepository] post-MVP by updating
/// the provider injection in main.dart — no other code changes needed.
class LocalWineRepository implements WineRepository {
  static const _dbName = 'brindar.db';
  static const _tableName = 'wines';
  static const _dbVersion = 1;

  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            barcode TEXT NOT NULL UNIQUE,
            name TEXT NOT NULL,
            type TEXT NOT NULL,
            origin TEXT NOT NULL,
            region TEXT NOT NULL,
            vintage TEXT NOT NULL,
            score TEXT NOT NULL,
            abv TEXT NOT NULL,
            body TEXT NOT NULL,
            temperature TEXT NOT NULL,
            tag TEXT NOT NULL,
            sommelierNote TEXT NOT NULL
          )
        ''');

        // Seed the MVP database with 3 sample wines
        final batch = db.batch();
        for (final wine in [
          Wine.seedRadal(),
          Wine.seedCondor(),
          Wine.seedPueblo(),
        ]) {
          batch.insert(_tableName, wine.toMap());
        }
        await batch.commit(noResult: true);
      },
    );
  }

  @override
  Future<List<Wine>> getAll() async {
    final db = await _database;
    final rows = await db.query(_tableName, orderBy: 'name ASC');
    return rows.map(Wine.fromMap).toList();
  }

  @override
  Future<Wine?> getByBarcode(String barcode) async {
    final db = await _database;
    final rows = await db.query(
      _tableName,
      where: 'barcode = ?',
      whereArgs: [barcode],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return Wine.fromMap(rows.first);
  }

  @override
  Future<void> save(Wine wine) async {
    final db = await _database;
    await db.insert(
      _tableName,
      wine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(Wine wine) async {
    final db = await _database;
    await db.update(
      _tableName,
      wine.toMap(),
      where: 'id = ?',
      whereArgs: [wine.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    final db = await _database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
