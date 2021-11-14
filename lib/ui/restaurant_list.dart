import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: JumpingDotsProgressIndicator(
              fontSize: 60,
            ),
          );
        } else if (state.state == ResultState.HasData) {
          var restaurant = state.result.restaurants;
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
                      child: restaurantViewCard(restaurant[index]),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 0,
                    )
                  ],
                );
              });
        } else if (state.state == ResultState.NoData) {
          return iconAndTextColumn(Icons.error_outline, '${state.message} Found');
        } else if (state.state == ResultState.Error) {
          return iconAndTextColumn(Icons.error_outline, state.message);
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
