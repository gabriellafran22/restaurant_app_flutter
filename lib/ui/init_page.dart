import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorites_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'home_page.dart';

class InitPage extends StatefulWidget {
  static const routeName = '/init_page';

  const InitPage({Key? key}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int _bottomNavIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectedNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  final List<Widget> _listWidget = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const SettingsPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex,
        items: [
          BottomNavigationBarItem(
            icon: _bottomNavIndex == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: HomePage.homePageTitle,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: SearchPage.searchPageTitle,
          ),
          BottomNavigationBarItem(
            icon: _bottomNavIndex == 2
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            label: FavoritesPage.favoritesPageTitle,
          ),
          BottomNavigationBarItem(
            icon: _bottomNavIndex == 3
                ? const Icon(Icons.settings)
                : const Icon(Icons.settings_outlined),
            label: SettingsPage.settingsPageTitle,
          ),
        ],
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
