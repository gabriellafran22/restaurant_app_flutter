import 'package:flutter/material.dart';
import 'package:restaurant_app/custom_widgets.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/ui/about_page.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText('Restaurant App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, AboutPage.routeName),
          ),
        ],
      ),
      body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurant.json'),
          builder: (context, snapshot) {
            final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
            return ListView.builder(
                itemCount: restaurants.length,
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
                              arguments: restaurants[index]);
                        },
                        child: _restaurantViewCard(restaurants[index]),
                      ),
                      const Divider(
                        thickness: 2,
                        height: 0,
                      )
                    ],
                  );
                });
          }),
    );
  }
}

Widget _restaurantViewCard(Restaurant restaurant) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    child: SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId)),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(restaurant.name),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      restaurant.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        iconAndText(
                            Icons.location_city, restaurant.city, Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        iconAndText(Icons.star, restaurant.rating.toString(),
                            Colors.yellow),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    ),
  );
}
