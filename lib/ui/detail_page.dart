import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/convert_data.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? ChangeNotifierProvider<RestaurantProvider>(
                  create: (_) => RestaurantProvider.detail(
                      apiService: ApiService(), id: widget.id),
                  child: Consumer<RestaurantProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 60,
                            color: Colors.red,
                          ),
                        );
                      } else if (state.state == ResultState.hasData) {
                        return _restaurantDetailView(
                            state.resultDetail.restaurant, context);
                      } else if (state.state == ResultState.noData) {
                        return Center(child: Text(state.message));
                      } else if (state.state == ResultState.error) {
                        return iconAndTextColumn(
                            Icons.error_outlined, state.message);
                      } else {
                        return const Center(child: Text(''));
                      }
                    },
                  ),
                )
              : iconAndTextColumn(
                  Icons.wifi_off, 'Please check your internet connection');
        },
        child: ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider.detail(
              apiService: ApiService(), id: widget.id),
          child: Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return Center(
                  child: JumpingDotsProgressIndicator(
                    fontSize: 60,
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                return _restaurantDetailView(
                    state.resultDetail.restaurant, context);
              } else if (state.state == ResultState.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.error) {
                return iconAndTextColumn(Icons.error_outlined, state.message);
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _restaurantDetailView(
    RestaurantDetail restaurant, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black12.withOpacity(0.6),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigation.back(),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _favoriteButton(restaurant.id, restaurant),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  iconAndTextRow(
                      Icons.location_city, restaurant.city, Colors.grey),
                  const SizedBox(
                    width: 10,
                  ),
                  iconAndTextRow(Icons.star, restaurant.rating.toString(),
                      Colors.yellowAccent),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              iconAndTextRow(
                  Icons.location_on, restaurant.address, Colors.black87),
              const SizedBox(
                height: 5,
              ),
              _listCategory(restaurant.categories),
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
            ],
          ),
        ),
        _tabSection(context, restaurant),
      ],
    ),
  );
}

Widget _favoriteButton(String id, RestaurantDetail restaurant) {
  return Consumer<DatabaseProvider>(
    builder: (context, state, child) {
      return FutureBuilder<bool>(
        future: state.isFavorited(id),
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;
          return FloatingActionButton(
            child: isFavorited
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              if (isFavorited) {
                state.deleteFavoriteRestaurant(id);
              } else {
                state.addFavoriteRestaurant(
                    convertRestaurantDetailToRestaurant(restaurant));
              }
            },
          );
        },
      );
    },
  );
}

Widget _tabSection(BuildContext context, RestaurantDetail restaurant) {
  return DefaultTabController(
    length: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Colors.red,
          child: const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Foods"),
                Tab(text: "Drinks"),
                Tab(text: "Reviews"),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            height: 300,
            child: TabBarView(children: [
              Container(
                child: _listFood(restaurant.menus.foods),
              ),
              Container(
                child: _listDrink(restaurant.menus.drinks),
              ),
              Container(
                child: _customerReview(restaurant.customerReviews),
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}

Widget _listCategory(List<Category> category) {
  String text = "";

  for (var name in category) {
    text += name.name;
    if (name.name != category.last.name) {
      text += ", ";
    }
  }

  return iconAndTextRow(Icons.category_rounded, text, Colors.black87);
}

Widget _listFood(List<Foods> food) {
  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          contentText(food[index].name),
        ],
      );
    },
    itemCount: food.length,
  );
}

Widget _listDrink(List<Drinks> drink) {
  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          contentText(drink[index].name),
        ],
      );
    },
    itemCount: drink.length,
  );
}

Widget _customerReview(List<CustomerReview> reviews) {
  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          reviewerReviewText(reviews[index].review),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reviewerNameText(reviews[index].name),
              reviewerDateText(reviews[index].date),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
            height: 0,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    },
    itemCount: reviews.length,
  );
}
