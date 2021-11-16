
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  static const String _tblFavorites = 'favorites';

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  DatabaseHelper._internal(){
    _instance = this;
  }

  Future<List<Restaurant>> getAllFavoriteRestaurant() async{
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorites);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteRestaurantById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
        _tblFavorites,
      where: 'id =?',
      whereArgs: [id],
    );

    if(results.isNotEmpty){
      return results.first;
    }

    return {};
  }

  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorites, restaurant.toJson());
  }

  Future<void> removeFavoriteRestaurant(String id) async {
    final db = await database;
    await db!.delete(
      _tblFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_app.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tblFavorites
          (id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL)
          '''
        );
      },
      version: 1,
    );
    return db;
  }

}