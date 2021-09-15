
import 'package:flutter/material.dart';
import 'package:flutterd/helpers/style.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/widgets/add_drower.dart';
import 'package:flutterd/widgets/custom_text.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';



class OrderCuisiner extends StatefulWidget {
  static const routeName = '/cuisiner_order';

  @override
  _OrderCuisinerState createState() => _OrderCuisinerState();
}

class _OrderCuisinerState extends State<OrderCuisiner> {
  final _etatFormKey = GlobalKey<FormState>();
  int _etat=0;
  int _id=0;


  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
  }



  _updateor() async {
    var isvalide = _etatFormKey.currentState.validate();
    if (!isvalide) {
      return;
    }
    _etatFormKey.currentState.save();

    bool isadd = await  Provider.of<CartState>(context, listen: false,).Updateetatorder(_id,_etat);
    if(!isadd) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("success update"),
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
    }else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Somthing is Wrong Try Agane to update "),
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
    final data = Provider.of<CartState>(context).oldorder;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders-Cuisiner"),
        backgroundColor: primary,
      ),

        drawer: Drawer(
          child: Column(
            children: [

              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: primary),
                accountName:CustomText(
                  //text: user.userModel?.name ?? "username lading...",
                  text: "welcome",
                  color: white,
                  weight: FontWeight.bold,
                  size: 18,
                ),
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
        ),

      body: Padding(
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

                      _UpdateAlert();
                    },
                    child: Text("Update etat order"),
                  )
                ],
              ),
            ),
          );
        },
      ),
        padding: EdgeInsets.all(12),



      ),
    );
  }



  void _UpdateAlert() {

    var alert = new AlertDialog(
      content: Form(
        key: _etatFormKey,
        child: Column(
          children: [

            TextFormField(
                decoration: InputDecoration(hintText: "Etat order"),
                validator: (v) {
                  if (v.isEmpty) {
                    return "Enter etat order 1:todo 2:inprogress 3:delvier 4:end ";
                  }
                  return null;
                },
                onSaved: (v) {
                  _etat= int.parse(v) ;
                }
            ),

          ],
        ),
      ),
      actions: <Widget>[

        FlatButton(
            onPressed: (){

              _updateor();
            }, child: Text('PUT')
        ),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

}
