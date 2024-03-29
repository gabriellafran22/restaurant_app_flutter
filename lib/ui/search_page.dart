import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  static const String searchPageTitle = 'Search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider.search(
          apiService: ApiService(), query: search),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          return Scaffold(
            appBar: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              search = '';
                            });
                          },
                        ),
                        hintText: 'Search a Menu or Restaurant',
                        border: InputBorder.none),
                    onChanged: (text) {
                      setState(() {
                        search = text;
                        state.fetchSearchRestaurant(search);
                        _resultHandler(context, state);
                      });
                    },
                    onSubmitted: (text) {
                      setState(() {
                        search = text;
                        state.fetchSearchRestaurant(search);
                        _resultHandler(context, state);
                      });
                    },
                  ),
                ),
              ),
            ),
            body: OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;
                return connected
                    ? search.isEmpty
                        ? iconAndTextColumn(
                            Icons.search, 'Search a Menu or Restaurant')
                        : _resultHandler(context, state)
                    : iconAndTextColumn(Icons.wifi_off,
                        'Please check your internet connection');
              },
              child: search.isEmpty
                  ? iconAndTextColumn(
                      Icons.search, 'Search a Menu or Restaurant')
                  : _resultHandler(context, state),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

Widget _resultHandler(BuildContext context, RestaurantProvider state) {
  if (state.state == ResultState.loading) {
    return Center(
      child: JumpingDotsProgressIndicator(
        fontSize: 60,
        color: Colors.red,
      ),
    );
  } else if (state.state == ResultState.hasData) {
    var restaurant = state.resultSearch.restaurants;
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
              )
            ],
          );
        });
  } else if (state.state == ResultState.noData) {
    return iconAndTextColumn(
        Icons.error_outline, '${state.message} Restaurant Found');
  } else if (state.state == ResultState.error) {
    return iconAndTextColumn(Icons.error_outline, state.message);
  } else {
    return const Center(child: Text(''));
  }
}
