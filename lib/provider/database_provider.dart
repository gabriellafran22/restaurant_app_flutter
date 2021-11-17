import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  List<Restaurant> _allFavoriteRestaurant = [];
  ResultState _state = ResultState.noData;
  String _message = '';

  DatabaseProvider({required this.databaseHelper}) {
    _getAllFavoriteRestaurant();
  }

  String get message => _message;

  ResultState get state => _state;

  List<Restaurant> get allFavoriteRestaurant => _allFavoriteRestaurant;

  void _getAllFavoriteRestaurant() async {
    _allFavoriteRestaurant = await databaseHelper.getAllFavoriteRestaurant();
    if (_allFavoriteRestaurant.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }

    notifyListeners();
  }

  void addFavoriteRestaurant(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavoriteRestaurant(restaurant);
      _getAllFavoriteRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void deleteFavoriteRestaurant(String id) async {
    try {
      await databaseHelper.removeFavoriteRestaurant(id);
      _getAllFavoriteRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant =
        await databaseHelper.getFavoriteRestaurantById(id);
    return favoritedRestaurant.isNotEmpty;
  }
}
