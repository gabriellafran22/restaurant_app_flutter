import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {
  static const String homePageTitle = 'Home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText('Restaurant App'),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? _restaurantList()
              : iconAndTextColumn(
                  Icons.wifi_off, 'Please check your internet connection');
        },
        child: _restaurantList(),
      ),
    );
  }
}

Widget _restaurantList() {
  return Consumer<RestaurantProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return Center(
          child: JumpingDotsProgressIndicator(
            fontSize: 60,
            color: Colors.red,
          ),
        );
      } else if (state.state == ResultState.hasData) {
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
                  onTap: () => Navigation.intentWithData(
                      DetailPage.routeName, restaurant[index].id),
                  child: restaurantCard(restaurant[index]),
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                )
              ],
            );
          },
        );
      } else if (state.state == ResultState.noData) {
        return iconAndTextColumn(Icons.error_outline, '${state.message} Found');
      } else if (state.state == ResultState.error) {
        return iconAndTextColumn(Icons.error_outline, state.message);
      } else {
        return const Center(child: Text(''));
      }
    },
  );
}
