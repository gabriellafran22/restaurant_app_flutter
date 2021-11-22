import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/settings/about_page.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';

class SettingsPage extends StatefulWidget {
  static const String settingsPageTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText('Settings'),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          color: Colors.black,
          context: context,
          tiles: <ListTile>[
            ListTile(
              title: const Text('Restaurant Notification'),
              subtitle:
                  const Text('Daily Notifications of a Random Restaurant'),
              trailing: _scheduling(),
            ),
            ListTile(
              title: const Text('About App'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}

Widget _scheduling() {
  return Consumer<PreferencesProvider>(
    builder: (context, preferences, child) {
      return Consumer<SchedulingProvider>(
        builder: (context, schedule, child) {
          return Switch.adaptive(
            value: preferences.isDailyRestaurantActive,
            onChanged: (value) async {
              if (Platform.isAndroid) {
                schedule.scheduledNews(value);
                preferences.setDailyRestaurant(value);
              } else {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('Available Soon!'),
                      content:
                          const Text('This feature will be available soon!'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigation.back();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      );
    },
  );
}
