import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Model/Note.dart';

class DbHelper {
  static const int _version = 1;
  static const String _dbName = "todo.db";
  static const String _tableName = "Note";

  static Future<Database> _getDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    Database database = await openDatabase(path, version: _version,
        onCreate: (Database db, version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, title TEXT NOT NULL,description TEXT NOT NULL);');
        });
    return database;
  }

  static Future<int> addNote(NoteModel noteModel) async {

    final db = await _getDb();
    return await db.insert(_tableName, noteModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(NoteModel noteModel) async {
    final db = await _getDb();

    return await db.update(_tableName, noteModel.toJson(),
        where: "id = ?",
        whereArgs: [noteModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(NoteModel noteModel) async {
    final db = await _getDb();

    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [noteModel.id],
    );
  }

  static Future<List<NoteModel>?> getAllNote() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    if (maps.isEmpty) {
      return null;
    } else {



      return List.generate(maps.length, (index) => NoteModel.fromJson(maps[index]));

    }
  }
}
