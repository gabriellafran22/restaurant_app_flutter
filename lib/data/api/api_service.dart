import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/restaurant.dart';
import 'dart:convert';

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String _listRestaurant = "list";
  static final String _searchRestaurant = "search?q=";
  static final String _detailRestaurant = "detail/";

  Future<RestaurantResult> getRestaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl+_listRestaurant));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantSearchResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl+_searchRestaurant+query));
    print(_baseUrl+_searchRestaurant+query);

    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl+_detailRestaurant+id));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load restaurant list');
    }
  }
}