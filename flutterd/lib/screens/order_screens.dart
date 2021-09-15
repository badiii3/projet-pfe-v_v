import 'package:flutter/material.dart';
import 'package:flutterd/helpers/style.dart';
import 'package:flutterd/models/cart.dart';
import 'package:flutterd/models/order.dart';
import 'package:flutterd/models/order.dart';
import 'package:flutterd/models/order.dart';
import 'package:flutterd/screens/cart_screens.dart';
import 'package:flutterd/screens/order_history_screens.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:provider/provider.dart';

class OrderNew extends StatefulWidget {
  static const routeName = '/order-now-screens';
  @override
  _OrderNewState createState() => _OrderNewState();
}

class _OrderNewState extends State<OrderNew> {
  final _form = GlobalKey<FormState>();
  int _num=0;
  int _etat=0;



  void _orderNew() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    final cart = Provider.of<CartState>(context, listen: false).cartModel;

    bool order = await Provider.of<CartState>(context, listen: false).ordercart(cart.id,_num,_etat);
    print("order = $order");
    if (order) {
      Navigator.of(context).pushNamed(OrderScreens.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Now"),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "num table"),
                  validator: (v) {
                     if (v.isEmpty) {
                       return "Enter Your  Number";
                     }
                    return null;
                  },
                  onSaved: (v) {
                       _num= int.parse(v) ;
                    }
                ),

                TextFormField(
                    decoration: InputDecoration(hintText: "etat order"),
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Enter etet order";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _etat=int.parse(v) ;
                    }
                ),



                Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _orderNew();
                      },
                      child: Text("Order"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreens.routeName);
                      },
                      child: Text("Edit Cart"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}