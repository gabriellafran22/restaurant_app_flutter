import 'package:restaurant_app/data/model/restaurant.dart';

// List<Restaurant> convertRestaurantDetailToRestaurant(List<RestaurantDetail> listRestaurantDetail){
//   var listRestaurant = <Restaurant>[];
//
//   listRestaurantDetail.forEach((restaurantDetail) {
//     var temp = Restaurant(
//         id: restaurantDetail.id,
//         name: restaurantDetail.name,
//         description: restaurantDetail.description,
//         pictureId: restaurantDetail.pictureId,
//         city: restaurantDetail.city,
//         rating: restaurantDetail.rating);
//
//     listRestaurant.add(temp);
//   });
//
//   return listRestaurant;
// }

Restaurant convertRestaurantDetailToRestaurant(RestaurantDetail restaurantDetail){
  return  Restaurant(
      id: restaurantDetail.id,
      name: restaurantDetail.name,
      description: restaurantDetail.description,
      pictureId: restaurantDetail.pictureId,
      city: restaurantDetail.city,
      rating: restaurantDetail.rating);
}