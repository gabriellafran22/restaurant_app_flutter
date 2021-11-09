import 'package:flutter/material.dart';
import 'package:restaurant_app/custom_widgets.dart';
import 'package:restaurant_app/data/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  Restaurant restaurant;

  DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(restaurant.pictureId)),
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black12.withOpacity(0.6),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(restaurant.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      iconAndText(
                          Icons.location_city, restaurant.city, Colors.grey),
                      const SizedBox(
                        width: 10,
                      ),
                      iconAndText(Icons.star, restaurant.rating.toString(),
                          Colors.yellowAccent),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  titleText('Description'),
                  const SizedBox(
                    height: 10,
                  ),
                  contentText(restaurant.description),
                  const SizedBox(
                    height: 20,
                  ),
                  titleText('Menu'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: titleText("Foods"),
                      ),
                      Expanded(
                        child: titleText("Drinks"),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: listFnB(restaurant.menus.foods),
                      ),
                      Expanded(
                        child: listFnB(restaurant.menus.drinks),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget listFnB(List<Food> drink) {
  List<Widget> text = [];
  int num = 1;

  for (var name in drink) {
    text.add(const SizedBox(
      height: 5,
    ));
    text.add(contentText("$num. ${name.name}"));
    num++;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: text,
  );
}
