import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/about_page.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/init_page.dart';
import 'package:restaurant_app/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         textTheme: GoogleFonts.ubuntuTextTheme(),
//       ),
//       initialRoute: HomePage.routeName,
//       routes: {
//         HomePage.routeName: (context) => const HomePage(),
//         AboutPage.routeName: (context) => const AboutPage(),
//         DetailPage.routeName: (context) => DetailPage(
//               id: ModalRoute.of(context)?.settings.arguments as String,
//             ),
//         SearchPage.routeName: (context) => const SearchPage(),
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
        ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.red,
                textTheme: GoogleFonts.ubuntuTextTheme(),
              ),
              initialRoute: InitPage.routeName,
              routes: {
                InitPage.routeName: (context) => const InitPage(),
                AboutPage.routeName: (context) => const AboutPage(),
                DetailPage.routeName: (context) => DetailPage(
                  id: ModalRoute.of(context)?.settings.arguments as String,
                ),
                SearchPage.routeName: (context) => const SearchPage(),
              },
            ),
    );
  }
}