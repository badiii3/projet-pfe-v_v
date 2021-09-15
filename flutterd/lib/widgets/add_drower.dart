import 'package:flutter/material.dart';
import 'package:flutterd/models/users.dart';

import 'package:provider/provider.dart';

import 'package:flutterd/screens/home_Screens.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/screens/order_history_screens.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:flutterd/widgets/custom_text.dart';
import 'package:localstorage/localstorage.dart';

import 'package:flutterd/helpers/style.dart';
import 'package:provider/provider.dart';

class AppDrower extends StatefulWidget {
  @override
  _AppDrowerState createState() => _AppDrowerState();
}

class _AppDrowerState extends State<AppDrower> {
  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final us = Provider.of<UserState>(context).users;
     print("here email users drower $us");


    return Drawer(
      child: Column(
        children: [

          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: primary),

            accountName:CustomText(
              //text: user.userModel?.name ?? "username lading...",
              text: us.toString() ?? "email lading...",
              //text: "welcome",
              color: white,
              weight: FontWeight.bold,
              size: 18,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
            },
            trailing: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrderScreens.routeName);
            },
            trailing: Icon(
              Icons.history,
              color: Colors.blue,
            ),
            title: Text("Old Orders"),
          ),
          Spacer(),
          ListTile(
            onTap: () {
              _logoutnew();
            },
            trailing: Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
