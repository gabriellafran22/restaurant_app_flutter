import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  var firstRestaurantTest = {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "pictureId": "14",
    "city": "Medan",
    "rating": 4.2
  };

  String jsonResponse = '''
  {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
          {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
              "pictureId": "14",
              "city": "Medan",
              "rating": 4.2
          },
          {
              "id": "s1knt6za9kkfw1e867",
              "name": "Kafe Kita",
              "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
              "pictureId": "25",
              "city": "Gorontalo",
              "rating": 4
          }
      ]
  }
  ''';

  final mock = MockClient();
  test(
      'Verify JSON Parsing, Check the id & name of the first restaurant from API',
      () async {
    //stub
    when(mock.get(Uri.parse("https://restaurant-api.dicoding.dev/list")))
        .thenAnswer((_) async => http.Response(jsonResponse, 200));
    //arrange
    RestaurantProvider restaurantProvider =
        RestaurantProvider(apiService: ApiService(client: mock));
    await restaurantProvider.fetchAllRestaurant();
    //act
    var testFromApiResultId = restaurantProvider.result.restaurants[0].id ==
        Restaurant.fromJson(firstRestaurantTest).id;
    var testFromApiResultName = restaurantProvider.result.restaurants[0].name ==
        Restaurant.fromJson(firstRestaurantTest).name;
    // assert
    expect(testFromApiResultId, true);
    expect(testFromApiResultName, true);
  });
}
