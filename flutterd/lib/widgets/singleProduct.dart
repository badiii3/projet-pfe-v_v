import 'package:flutter/material.dart';
import 'package:flutterd/screens/product_details_screens.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final int price;


  const SingleProduct({
    Key key,
    this.id,
    this.title,
    this.image,
    this.price

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailsScreens.routeName,
            arguments: id,
          );
        },
        child: Image.network(
          "$image",
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(

        backgroundColor: Colors.black54,

        title: Text(title),


      ),
    );
  }
}
