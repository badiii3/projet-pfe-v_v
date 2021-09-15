import 'package:flutter/material.dart';
import 'package:flutterd/screens/Admin.dart';
import 'package:flutterd/screens/Manager_screens.dart';
import 'package:flutterd/screens/ProductSearchScreen.dart';
import 'package:flutterd/screens/cart_screens.dart';
import 'package:flutterd/screens/cuisiner_order.dart';

import 'package:flutterd/screens/home_Screens.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/screens/order_history_screens.dart';
import 'package:flutterd/screens/order_screens.dart';
import 'package:flutterd/screens/product_details_screens.dart';
import 'package:flutterd/screens/welcome_page.dart';

import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';


main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('usertoken');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductState()),
        ChangeNotifierProvider(create: (ctx) => UserState()),
        ChangeNotifierProvider(create: (ctx) => CartState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return WelcomePage();
            }
            return HomeScreens();
          },
        ),
        routes: {
          HomeScreens.routeName: (ctx) => HomeScreens(),
          ProductDetailsScreens.routeName: (ctx) => ProductDetailsScreens(),
          LoginScrrens.routeName: (ctx) => LoginScrrens(),
          WelcomePage.routeName: (ctx) => WelcomePage(),
          CartScreens.routeName: (ctx) => CartScreens(),
          OrderScreens.routeName: (ctx) => OrderScreens(),
          OrderNew.routeName: (ctx) => OrderNew(),
          ProductSearchScreen.routeName: (ctx) => ProductSearchScreen(),
          Admin.routeName: (ctx) => Admin(),
          ManagerHome.routeName: (ctx) => ManagerHome(),
          OrderCuisiner.routeName: (ctx) => OrderCuisiner(),
        },
      ),
    );
  }
}
