import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';

class NoInternetPage extends StatelessWidget {
  static const routeName = '/noInternet_page';

  NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: titleText('Restaurant App'),
        ),
        body: Center(
          child: titleText('No Internet'),
        ), 
    );
  }
  
}