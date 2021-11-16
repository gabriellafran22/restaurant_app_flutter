import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

import 'detail_page.dart';

class FavoritesPage extends StatelessWidget {
  static const String favoritesPageTitle = 'Favorites';

  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText('Favorites'),
      ),
      body: favoriteRestaurantList(context),
    );
  }
}

Widget favoriteRestaurantList(BuildContext context) {
  return Consumer<DatabaseProvider>(builder: (context, state, _) {
    if (state.state == ResultState.hasData) {
      var restaurant = state.allFavoriteRestaurant;
      return ListView.builder(
        shrinkWrap: true,
        itemCount: restaurant.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DetailPage.routeName,
                      arguments: restaurant[index].id);
                },
                child: restaurantCard(restaurant[index]),
              ),
              const Divider(
                thickness: 2,
                height: 0,
              ),
            ],
          );
        },
      );
    } else {
      return iconAndTextColumn(Icons.favorite, 'No Favorited Restaurant');
    }
  });
}
