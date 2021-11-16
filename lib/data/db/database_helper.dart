
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
    print('get all fav resto helper');
    final db = await database;
    print('get all fav resto helper 2');
    List<Map<String, dynamic>> results = await db!.query(_tblFavorites);
    print('get all fav resto helper 3');

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteRestaurantById(String id) async {
    final db = await database;
    print('get fav resto by id $id 1');
    List<Map<String, dynamic>> results = await db!.query(
        _tblFavorites,
      where: 'id =?',
      whereArgs: [id],
    );
    print('get fav resto by id $id 2');

    if(results.isNotEmpty){
      print('get fav resto by id $id if return first ');
      return results.first;
    }
    print('get fav resto by id $id return null');

    return {};
  }

  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    print('add fav resto helper ${restaurant.id} 1');
    final db = await database;
    print('add fav resto helper ${restaurant.id} 2');
    await db!.insert(_tblFavorites, restaurant.toJson());
    print('add fav resto helper ${restaurant.id} 3');
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