import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterd/helpers/style.dart';
import 'package:flutterd/screens/cart_screens.dart';
import 'package:flutterd/screens/ProductSearchScreen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/add_drower.dart';
import 'package:flutterd/widgets/custom_text.dart';
import 'package:flutterd/widgets/singleProduct.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  static const routeName = '/home-screens';

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  bool _init = true;
  bool _isLoding = false;



  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<CartState>(context).getCartDatas();
      Provider.of<CartState>(context).getoldOrders();
      _isLoding = await Provider.of<ProductState>(context).getProducts();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).poducts;
    if (!_isLoding)
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: white),
          elevation: 0.5,
          backgroundColor: primary,
          title: CustomText(
            text: "welcome resto&café",
            color: white,
          ),

        ),
        body: Center(
          child: Text("Somthing is Wrong Try Agane!"),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: white),
          elevation: 0.5,
          backgroundColor: primary,
          title: CustomText(
            text: "welcome resto&café",
            color: white,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreens.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ],
        ),
        drawer: AppDrower(),
          body:SafeArea(
            child: ListView(
                children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: primary,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                      ),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only( top: 8, left: 8, right: 8, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.search,
                          color: red,
                        ),
                        title: TextField(
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(

                              hintText: "Find food ",
                              border: InputBorder.none,
                           ),
                             onSubmitted: (pattern)async {

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductSearchScreen()));
                          }

                        ),

                      ),
                    ),
                  ),

                ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,

                  ),

                  
                  Container(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3 / 2,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: product.length,
                      itemBuilder: (ctx, i) => SingleProduct(
                        id: product[i].id,
                        title: product[i].title,
                        image: product[i].image,

                      ),

                    ),


                  ),


                ]

            ),




          ),
      );
  }
}
