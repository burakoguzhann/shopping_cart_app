import 'package:path/path.dart';
import 'package:shopping_cart/models/products_models.dart';
import 'package:sqflite/sqflite.dart';

class ProdutcsSqlite {
   Database? _database;

  Future<void> OpenDatabaseProduct() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'products3_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE products(title TEXT, price INTEGER, quantity INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> insertProducts(ProductModels productModel) async {
    final db = _database;
    if (db != null) {
      await db.insert(
        'products',
        productModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception(
        'Database is not initialized. Call OpenDatabaseProduct() first.',
      );
    }
  }

  Future<List<ProductModels>> getProducts() async {
    final db = _database;
    if (db != null) {
      final List<Map<String, dynamic>> productMap = await db.query('products');
      return productMap.map((e) => ProductModels.fromJson(e)).toList();
    } else {
      throw Exception(
        'Database is not initialized. Call OpenDatabaseProduct() first.',
      );
    }
  }
}
