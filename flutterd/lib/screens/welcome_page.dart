import 'package:flutter/material.dart';

import 'package:flutterd/screens/welcome_page.dart';

import 'login_screens.dart';

class WelcomePage extends StatefulWidget {
  static const routeName = '/welcome-page';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget button({
    @required String name,
    Color color,
    Color textColor,
  }) {
    return Container(
      height: 45,
      width: 300,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade400, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
        },
        child: Text(name, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(child: Image.asset('images/logo.jpg')),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome to Resto-Cofe",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                  Column(
                    children: [
                      Text("Welcome to your coffee restaurent application "),
                      Text("Please click to continue ")
                    ],
                  ),
                  button(
                    name: 'Enter To App',
                    color: Colors.grey.shade300,
                    textColor: Colors.white,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
