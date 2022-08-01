import 'package:foodpanda_users_app/mainScreens/LocationScreen.dart';
import 'package:foodpanda_users_app/mainScreens/SettingsScreen.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';

import '../mainScreens/cart_screen.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      SafeArea(child: WillPopScope(child: HomeScreen(), onWillPop: () async {return false;})),
      SafeArea(child: WillPopScope(child: LocationScreen(), onWillPop: () async {return false;})),
      SafeArea(child: WillPopScope(child: CartScreen(), onWillPop: () async {return false;})),
      SafeArea(child: WillPopScope(child: SettingsScreen(), onWillPop: () async {return false;})),
    ];
    return myList[index];
  }
}