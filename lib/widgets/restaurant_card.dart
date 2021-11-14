import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import 'custom_widgets.dart';

Widget restaurantViewCard(Restaurant restaurant) {
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
                child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}")),
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
                      iconAndTextRow(
                          Icons.location_city, restaurant.city, Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      iconAndTextRow(Icons.star, restaurant.rating.toString(),
                          Colors.yellow),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}