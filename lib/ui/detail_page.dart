import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String id;

  DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider.detail(apiService: ApiService(), id: widget.id),
            child: Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(child: JumpingDotsProgressIndicator(fontSize: 60,),);
                }
                else if (state.state == ResultState.HasData) {
                  return _restaurantDetailView(state.resultDetail.restaurant, context);
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
            ),
          )
    );
  }
}

Widget _restaurantDetailView(RestaurantDetail restaurant, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Hero(
                tag: restaurant.pictureId,
                child: Image.network("https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}")),
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black12.withOpacity(0.6),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context,),
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
              Text(
                  restaurant.name,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)
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
              iconAndTextRow(Icons.location_on, restaurant.address, Colors.black87),
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
                    child: _listFood(restaurant.menus.foods),
                  ),
                  Expanded(
                    child: _listDrink(restaurant.menus.drinks),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              titleText('Customer Reviews'),
              _customerReview(restaurant.customerReviews),
              // _tabSection(context, restaurant),
              // _tabSection(restaurantDetail: restaurant,),
            ],
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
    if (name.name != category.last.name){
      text += ", ";
    }
  }

  return iconAndTextRow(Icons.category_rounded, text, Colors.black87);
}

Widget _listFood(List<Foods> food) {
  List<Widget> widget = [];
  int num = 1;

  for (var name in food) {
    widget.add(const SizedBox(
      height: 5,
    ));
    widget.add(contentText("$num. ${name.name}"));
    num++;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widget,
  );
}

Widget _listDrink(List<Drinks> drink) {
  List<Widget> widget = [];
  int num = 1;

  for (var name in drink) {
    widget.add(const SizedBox(
      height: 5,
    ));
    widget.add(contentText("$num. ${name.name}"));
    num++;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widget,
  );
}

Widget _customerReview(List<CustomerReview> reviews) {
  List<Widget> widget = [];

  for (var review in reviews) {
    widget.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          reviewerReviewText(review.review),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reviewerNameText(review.name),
              reviewerDateText(review.date),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
            height: 0,
          ),
        ],
      )
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widget,
  );
}

// class _tabSection extends StatefulWidget {
//   RestaurantDetail restaurantDetail;
//
//   _tabSection({required this.restaurantDetail});
//
//   @override
//   _tabSectionState createState() => _tabSectionState();
// }
//
// class _tabSectionState extends State<_tabSection> with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = new TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     RestaurantDetail restaurant = widget.restaurantDetail;
//
//     return  DefaultTabController(
//       length: 2,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             child: TabBar(
//               controller: tabController,
//                 labelColor: Colors.black,
//                 tabs: [
//                   Tab(text: "Menu"),
//                   Tab(text: "Customer Reviews"),
//                 ]),
//           ),
//           Container(
//             //Add this to give height
//             height: 300,
//             child: TabBarView(
//                 children: [
//                   Scrollbar(
//                       child:  Container(
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: titleText("Foods"),
//                                   ),
//                                   Expanded(
//                                     child: titleText("Drinks"),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: _listFood(restaurant.menus.foods),
//                                   ),
//                                   Expanded(
//                                     child: _listDrink(restaurant.menus.drinks),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                       ),
//                   ),
//                   Container(
//                     child: Text('aaa'),
//                   ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
//
// }

// Widget _tabSection(BuildContext context, RestaurantDetail restaurant) {
//   return DefaultTabController(
//     length: 2,
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           child: TabBar(
//               labelColor: Colors.black,
//               tabs: [
//             Tab(text: "Home"),
//             Tab(text: "Articles"),
//           ]),
//         ),
//         Container(
//           //Add this to give height
//           height: 300,
//           child: TabBarView(children: [
//             Container(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: titleText("Foods"),
//                       ),
//                       Expanded(
//                         child: titleText("Drinks"),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: _listFood(restaurant.menus.foods),
//                       ),
//                       Expanded(
//                         child: _listDrink(restaurant.menus.drinks),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             ),
//             Container(
//               child: _customerReview(restaurant.customerReviews),
//             ),
//           ]),
//         ),
//       ],
//     ),
//   );
// }
