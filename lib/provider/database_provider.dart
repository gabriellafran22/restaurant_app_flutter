import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  List<Restaurant> _allFavoriteRestaurant = [];
  ResultState _state = ResultState.noData;
  // late ResultState _state;
  String _message = '';

  DatabaseProvider({required this.databaseHelper}){
    print('constructor provider');
    _getAllFavoriteRestaurant();
  }

  String get message => _message;
  ResultState get state => _state;
  List<Restaurant> get allFavoriteRestaurant => _allFavoriteRestaurant;

  void _getAllFavoriteRestaurant() async {
    print('get all fav resto provider');
    _allFavoriteRestaurant = await databaseHelper.getAllFavoriteRestaurant();
    print('get all fav resto provider 2');
    if(_allFavoriteRestaurant.isNotEmpty) {
      print('get all fav resto provider if');
      _state = ResultState.hasData;
    }
    else {
      print('get all fav resto provider else');
      _state = ResultState.noData;
      _message = 'Empty Data';
    }

    notifyListeners();
  }

  void addFavoriteRestaurant(Restaurant restaurant) async {
    print('add fav resto ${restaurant.id} 1');
    try {
      await databaseHelper.insertFavoriteRestaurant(restaurant);
      print('add fav resto ${restaurant.id} 2');
      _getAllFavoriteRestaurant();
      print('add fav resto ${restaurant.id} 3');
    }
    catch (e) {
      print('add fav resto ${restaurant.id} 4');

      _state = ResultState.error;
      print('add fav resto ${restaurant.id} 5');

      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void deleteFavoriteRestaurant(String id) async {
    try {
      await databaseHelper.removeFavoriteRestaurant(id);
      _getAllFavoriteRestaurant();
    }
    catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    print('isfavorited provider 1');
    final favoritedRestaurant = await databaseHelper.getFavoriteRestaurantById(id);
    print('isfavorited provider 2');
    return favoritedRestaurant.isNotEmpty;
  }


}