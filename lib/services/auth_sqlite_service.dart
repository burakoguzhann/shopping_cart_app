import 'package:path/path.dart';
import 'package:shopping_cart/models/user_models.dart';
import 'package:sqflite/sqflite.dart';

class AuthSqliteService {
  late Database _database;
  Future<void> OpenDatabaseFunc() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'auth_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE users(email TEXT, password TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertUser(UserModel userModel) async {
    final db = await _database;
    await db.insert(
      'users',
      userModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool?> loginUser(UserModel userModel) async {
    final db = await _database;
    if (db == null) return false;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [userModel.email, userModel.password],
    );
    return result.isNotEmpty;
  }
}
