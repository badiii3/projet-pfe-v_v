import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/helpers/style.dart';
import 'package:flutterd/models/product.dart';
import 'package:flutterd/models/product.dart';

import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ManagerHome extends StatefulWidget {
  static const routeName = '/Manager_screens';

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {

  final _categoryFormKey = GlobalKey<FormState>();
  final _tableFormKey = GlobalKey<FormState>();
  final _productsFormKey =GlobalKey<FormState>();



  GlobalKey<FormState> _tableslistFormKey = GlobalKey();
  GlobalKey<FormState> _categorylistFormKey =GlobalKey();

  GlobalKey<FormState> _productlistFormKey = GlobalKey();

  int _num=0;
  int _capacite=0;
  String _title ='';
  String _description ='';
  int _Price=0;






  chooseImage() {
    setState(() {
      FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg','png'],);
    });
  }



  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
  }


  _addTables() async {
    var isvalide = _tableFormKey.currentState.validate();
    if (!isvalide) {
      return;
    }
    _tableFormKey.currentState.save();
    bool isadd = await  Provider.of<ProductState>(context, listen: false,).addTables(_num,_capacite,);
    if(!isadd) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("success register"),
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
              title: Text("Somthing is Wrong Try Agane to add "),
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


  _addcategory() async {
  var isvalide = _categoryFormKey.currentState.validate();
  if (!isvalide) {
    return;
  }
  _categoryFormKey.currentState.save();
  bool isadd = await  Provider.of<ProductState>(context, listen: false,).addCategory(_title);
  if(!isadd) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("success register"),
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
            title: Text("Somthing is Wrong Try Agane to add "),
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

  _Updatecategory(){

  }


  _addproduct() async {
    var isvalide = _productsFormKey.currentState.validate();
    if (!isvalide) {
      return;
    }
    _productsFormKey.currentState.save();
    bool isadd = await  Provider.of<ProductState>(context, listen: false,).addProducts(_title,_Price,_title,_description);
    if(!isadd) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("success register"),
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
              title: Text("Somthing is Wrong Try Agane to add "),
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
void didChangeDependencies() async {

    Provider.of<ProductState>(context).gettable();
    Provider.of<ProductState>(context).getCategory();
    Provider.of<ProductState>(context).getProducts();

    setState(() {});

  super.didChangeDependencies();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: Text(
          "welcome manager",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add products"),
            onTap: () {
              _productsAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text("products list"),
            onTap: () {
              _ListproductsAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text("Add Tables"),
            onTap: () {
              _TablesAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.arrow_forward_ios_sharp),
            title: Text("Tables list"),
            onTap: () {
              _ListTablesAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text("Add Categorys"),
            onTap: () {
              _CategoryAlert();
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.article),
            title: Text("Categorys list"),
            onTap: () {
              _ListCategorysAlert();
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text("Order"),
            onTap: () {
              _OrderAlert();
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_forward_outlined),
            title: Text("logout"),
            onTap: () {
              _logoutnew();
            },
          ),
        ],
      ),
    );
  }


  _TablesAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _tableFormKey,
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(hintText: "num table"),
                validator: (v) {
                  if (v.isEmpty) {
                    return "Enter Your num table";
                  }
                  return null;
                },
                onSaved: (v) {
                  _num = int.parse(v) ;
                }
            ),

            TextFormField(
                decoration: InputDecoration(hintText: "capacite"),
                validator: (v) {
                  if (v.isEmpty) {
                    return "Enter capacite";
                  }
                  return null;
                },
                onSaved: (v) {
                  _capacite = int.parse(v) ;
                }
            ),


          ],
        ),
      ),
      actions: <Widget>[

        FlatButton(
            onPressed: (){
              _addTables();
            }, child: Text('ADD')
        ),
        FlatButton(onPressed: (){
          Navigator.pop(context);
          }, child: Text('CANCEL')),

      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _ListTablesAlert() {

  final liste = Provider.of<ProductState>(context,listen: false).table;
  var alert = new AlertDialog(

    content: SingleChildScrollView(

      key: _tableslistFormKey,

      child: Container(

        width: 845.6,
        height: 672.0,

        child:
        DataTable(

          columns: [

            DataColumn(label: Text("num ")),
            DataColumn(label: Text("capacite")),
            DataColumn(label: Text("Action")),
          ],

          rows: liste.map((data) =>
          // we return a DataRow every time
          DataRow(
              cells: [

                DataCell(Text(data.num.toString() )),
                DataCell(Text(data.capacite.toString() )),
                DataCell(Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.edit_outlined),
                      onPressed: () {

                      },),

                    IconButton(icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<ProductState>(context,listen:false).deletetable(data.num);
                      },),

                  ],
                ),
                ),

              ]))
              .toList(),
        ),
      ),
    ),

    actions: <Widget>[
      FlatButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text('CANCEL')),
    ],

  );


  showDialog(context: context, builder: (_) => alert);
}

  _CategoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: Column(
          children: [


            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Enter Category';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Title",
              ),
              onSaved: (v) {
                _title = v;
              },
            ),


          ],
        ),
      ),
      actions: <Widget>[

        FlatButton(
            onPressed: (){
              _addcategory();
            }, child: Text('ADD')
        ),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);



  }

  void _ListCategorysAlert() {

    final liste = Provider.of<ProductState>(context,listen: false).category;
    var alert = new AlertDialog(

      content: SingleChildScrollView(

        key: _categorylistFormKey,

        child: Container(

          width: 845.6,
          height: 672.0,

          child:
          DataTable(

            columns: [
              DataColumn(label: Text("ID ")),
              DataColumn(label: Text("title")),
              DataColumn(label: Text("Action")),
            ],

            rows: liste.map((data) =>
            // we return a DataRow every time
            DataRow(
                cells: [

                  DataCell(Text(data.id.toString() )),
                  DataCell(Text(data.title.toString() )),
                  DataCell(Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          //Provider.of<ProductState>(context,listen:false).UpdateCategory(data.id,data.title);
                          _Updatecategory();

                        },),

                      IconButton(icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<ProductState>(context, listen: false).deleteCategory(data.id);
                        },),

                    ],
                  ),
                  ),

                ]))
                .toList(),
          ),
        ),
      ),

      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),
      ],

    );


    showDialog(context: context, builder: (_) => alert);

  }

  void _productsAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _productsFormKey,
        child: Column(
          children: [
            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Enter title product';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "title product",
              ),
              onSaved: (v) {
                _title = v;
              },
            ),


            TextFormField(
                decoration: InputDecoration(hintText: "price"),
                validator: (v) {
                  if (v.isEmpty) {
                    return "Enter price";
                  }
                  return null;
                },
                onSaved: (v) {
                  _Price= int.parse(v) ;
                }
            ),
            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Enter description';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "description",
              ),
              onSaved: (v) {
                _description = v;
              },
            ),

            SizedBox(height: 48),


            // ignore: deprecated_member_use
            OutlineButton(
              onPressed: chooseImage,

              child: Text('Choose Image'),

            ),


            SizedBox(
              height: 20.0,
            ),


          ],
        ),
      ),

        key: _categoryFormKey,
        title: Column(
          children: [
            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Enter Category';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Title category",
              ),
              onSaved: (v) {
                _title = v;
              },
            ),


          ],
        ),

      actions: <Widget>[

        FlatButton(
            onPressed: (){
              _addproduct();
            }, child: Text('ADD')
        ),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _ListproductsAlert() {
    final liste = Provider.of<ProductState>(context,listen: false).poducts;

    var alert = new AlertDialog(

      content: SingleChildScrollView(

        key: _productlistFormKey,

        child: Container(

          child:
          DataTable(

            columns: [
              DataColumn(label: Text("title")),

              DataColumn(label: Text("Price ")),
              DataColumn(label: Text("description ")),
              DataColumn(label: Text("Action")),
            ],

            rows: liste.map((data) =>
            // we return a DataRow every time
            DataRow(
                cells: [
                  DataCell(Text(data.title.toString() )),
                  DataCell(Text(data.Price.toString() )),
                  DataCell(Text(data.description.toString() )),

                  DataCell(Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.edit_outlined),
                        onPressed: () {

                        },),

                      IconButton(icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<ProductState>(context, listen: false).deleteProduct(data.id);
                        },),

                    ],
                  ),
                  ),

                ]))
                .toList(),
          ),
        ),
      ),

      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),
      ],

    );


    showDialog(context: context, builder: (_) => alert);


  }

  void _OrderAlert() {
    final data = Provider.of<CartState>(context, listen: false ).oldorder;
    var alert = new AlertDialog(


      content: Container(
        width: 845.6,
        height: 672.0,
        child: Form(


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
                        child: Text("Delete order"),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: <Widget>[


        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);

  }


}