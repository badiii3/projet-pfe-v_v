import 'package:flutter/material.dart';
import 'package:flutterd/helpers/style.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/widgets/add_drower.dart';
import 'package:provider/provider.dart';

class OrderScreens extends StatelessWidget {
  static const routeName = '/order-screens';
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartState>(context).oldorder  ;
    final cartt = Provider.of<CartState>(context).cartModel;



    return Scaffold(
      appBar: AppBar(
        title: Text("Old Orders"),
        backgroundColor: primary,
      ),
      drawer: AppDrower(),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, i) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("numero table : ${data[i].table.num}"),
                        Text("Total : ${data[i].cart.total}"),
                        Text("Etat order : ${data[i].etat.toString()}"),
                        Text(data[i].cart.date.toString()),
                      ],
                    ),
                    RaisedButton(
                      color: Colors.greenAccent,
                      onPressed: () {

                      },
                      child: Text("Update etat order"),
                    )
                  ],
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}