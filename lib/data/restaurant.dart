import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'].toDouble(),
        menus: Menus.fromJson(restaurant['menus']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
        'menus': menus.toJson(),
      };
}

class Menus {
  late List<Food> foods;
  late List<Food> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: List<Food>.from(menus['foods'].map((x) => Food.fromJson(x))),
        drinks: List<Food>.from(menus['drinks'].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'foods': List<dynamic>.from(foods.map((x) => x.toJson())),
        'drinks': List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Food {
  late String name;

  Food({
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> food) => Food(
        name: food['name'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) return [];

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
