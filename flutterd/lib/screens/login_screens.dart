import 'package:flutter/material.dart';
import 'package:flutterd/helpers/style.dart';
import 'package:flutterd/screens/Manager_screens.dart';
import 'package:flutterd/screens/cuisiner_order.dart';
import 'package:flutterd/screens/home_Screens.dart';
import 'package:flutterd/screens/order_screens.dart';

import 'package:flutterd/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:flutterd/screens/Admin.dart';

import 'order_history_screens.dart';

class LoginScrrens extends StatefulWidget {
  static const routeName = '/login-screens';

  @override
  _LoginScrrensState createState() => _LoginScrrensState();
}

class _LoginScrrensState extends State<LoginScrrens> {
  String _email= '';
  String _password = '';
  LocalStorage rolestorage = new LocalStorage('role');


  final _form = GlobalKey<FormState>();

  void _loginNew() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();

    bool istoken  = await Provider.of<UserState>(
      context,
      listen: false,
    ).loginNow(_email, _password);
    if (istoken && rolestorage.getItem('role')=="3")  {
      Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
    }
    else if(istoken && rolestorage.getItem('role')=="4" ){
      Navigator.of(context).pushReplacementNamed(OrderCuisiner.routeName);

    }
    else if(istoken && rolestorage.getItem('role')=="2" ){
      Navigator.of(context).pushReplacementNamed(ManagerHome.routeName);

    }
    else if(istoken && rolestorage.getItem('role')=="1" ){
      Navigator.of(context).pushReplacementNamed(Admin.routeName);

    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Something is wrong.Try Again"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Login Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter Your Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "email",
                  ),
                  onSaved: (v) {
                    _email = v;
                  },
                ),
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter Your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  onSaved: (v) {
                    _password = v;
                  },
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _loginNew();
                      },
                      child: Text("Login"),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
