import 'package:restaurant_app/data/model/restaurant.dart';

Restaurant convertRestaurantDetailToRestaurant(RestaurantDetail restaurantDetail){
  return  Restaurant(
      id: restaurantDetail.id,
      name: restaurantDetail.name,
      description: restaurantDetail.description,
      pictureId: restaurantDetail.pictureId,
      city: restaurantDetail.city,
      rating: restaurantDetail.rating);
}