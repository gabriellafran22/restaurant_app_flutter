import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/about_page.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';

class SettingsPage extends StatefulWidget{
  static const String settingsPageTitle = 'Settings';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  bool notif = false;


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
              subtitle: const Text('Daily Notifications of a Random Restaurant'),
              trailing: Switch.adaptive(
                  value: notif,
                  onChanged: (value){
                    setState(() {
                      notif = value;
                    });
                  },
              ),
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