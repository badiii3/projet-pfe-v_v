import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterd/helpers/style.dart';
import 'package:flutterd/screens/cart_screens.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/custom_text.dart';
import 'package:flutterd/widgets/singleProduct.dart';


import 'package:provider/provider.dart';

class ProductSearchScreen extends StatefulWidget {
  static const routeName = '/ProductSearchScreen';

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();

}


class _ProductSearchScreenState extends State<ProductSearchScreen>  {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).poducts;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: CustomText(text: "Products", size: 20,),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){Navigator.of(context).pushNamed(CartScreens.routeName);})
        ],
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search, color: grey, size: 30,),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(text: "No products Found", color: grey, weight: FontWeight.w300, size: 22,),
            ],
          ),


        ],
      ),


    );
  }
}