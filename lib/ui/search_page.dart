import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:restaurant_app/ui/search_list.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  // final textFieldContoller = TextEditingController();
  String search = '';
  // late Widget trySearch;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   trySearch = ChangeNotifierProvider<RestaurantProvider>(
  //     create: (_) => RestaurantProvider.search(apiService: ApiService(), query: search),
  //     child: RestaurantSearchList(),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                // controller: textFieldContoller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        //TODO: clear when pressed
                        // textFieldContoller.clear();
                      },
                    ),
                    hintText: 'Search Restaurant',
                    border: InputBorder.none
                ),
                onChanged: (text) {
                  //TODO: saerch
                  setState(() {
                    search = text;
                    RestaurantSearchList(query: search,);
                  });
                },
                onSubmitted: (text) {
                  //TODO: search
                  setState(() {
                    search = text;
                    RestaurantSearchList(query: search,);
                  });
                },
              ),
            ),
          ),
      ),
        body: ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider.search(apiService: ApiService(), query: search),
            child: RestaurantSearchList(query: search,),
        ),
    );
  }
}

// Widget trySearch(String search) {
//   return ChangeNotifierProvider<RestaurantProvider>(
//     create: (_) => RestaurantProvider.search(apiService: ApiService(), query: search),
//     child: RestaurantSearchList(),
//   );
// }