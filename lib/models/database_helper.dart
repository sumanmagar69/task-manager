import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async => _database ??= await _initDB();
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, date TEXT NOT NULL, level TEXT NOT NULL, completed INTEGER NOT NULL)');
    });
  }
  Future<int> insertTask(Task task) async => (await database).insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  Future<List<Task>> getTasks() async => (await database).query('tasks').then((rows) => rows.map(Task.fromMap).toList());
  Future<int> updateTask(Task task) async => (await database).update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  Future<int> deleteTask(int id) async => (await database).delete('tasks', where: 'id = ?', whereArgs: [id]);
  Future<int> deleteAllTasks() async => (await database).delete('tasks');
}
