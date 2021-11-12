import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';

class RestaurantSearchList extends StatelessWidget{
  final String query;

  const RestaurantSearchList({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if(state.state == ResultState.Loading) {
          return Center(child: JumpingDotsProgressIndicator(fontSize: 60,),);
        }
        else if (state.state == ResultState.HasData) {
          // state.fetchSearchRestaurant(query);
        var restaurant = state.resultSearch.restaurants;
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