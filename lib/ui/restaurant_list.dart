import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';


class RestaurantList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if(state.state == ResultState.Loading) {
          return Center(child: JumpingDotsProgressIndicator(fontSize: 60,),);
        }
        else if (state.state == ResultState.HasData) {
          var restaurant = state.result.restaurants;
          return  ListView.builder(
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
                    child: restaurantViewCard(restaurant[index]),
                  ),
                  const Divider(
                    thickness: 2,
                    height: 0,
                  )
                ],
              );
            });
        }
        else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 50,),
                contentText(state.message),
              ],
            ),
          );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

}


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
                child: Image.network("https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}")),
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
              ),
          ),
        ],
      ),
    ),
  );
}