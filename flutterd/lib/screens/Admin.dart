import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:flutterd/models/users.dart';
import 'package:flutterd/models/supplier.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  static const routeName = '/Admin';
  @override
  _AdminState createState() => _AdminState();

}

class _AdminState extends State<Admin> {


  String _username = '';
  String _password = '';
  String _confpassword = '';
  String _email='';
  String _role = '';
  String _name_s= '';
  int _phone=0;
  String _services='';
  String _Article='';
  int _quantite =0;
  String _categories ='';


  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
  }


  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;

  TextEditingController usersontroller = TextEditingController();

  TextEditingController supplierController = TextEditingController();
  TextEditingController userslistController = TextEditingController();

  GlobalKey<FormState> _userslistFormKey = GlobalKey();

  GlobalKey<FormState> _stocklistFormKey = GlobalKey();



  final _form = GlobalKey<FormState>();
  final _supplierFormKey = GlobalKey<FormState>();
  final _stockFormKey = GlobalKey<FormState>();




  @override
  void didChangeDependencies() async {

     Provider.of<UserState>(context).getUsers();
     Provider.of<UserState>(context).getSupplier();
     Provider.of<UserState>(context).getStock();

      setState(() {});

    super.didChangeDependencies();
  }


  _registerNow() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    bool isregis = await Provider.of<UserState>(
      context,
      listen: false,
    ).registernow(_username, _password ,_email,_role);
   if(!isregis) {
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
             title: Text("Somthing is Wrong Try Agane register"),
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


  _addsupp() async {
    var isvalide = _supplierFormKey.currentState.validate();
    if (!isvalide) {
      return;
    }
    _supplierFormKey.currentState.save();
    bool isadd = await  Provider.of<UserState>(context, listen: false,).addSupplier(_name_s,_phone,_services);
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


  _addstock() async {
    var isvalide = _stockFormKey.currentState.validate();
    if (!isvalide) {
      return;
    }
    _stockFormKey.currentState.save();
    bool isadd = await  Provider.of<UserState>(context, listen: false,).addStock(_Article,_quantite,_categories);
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
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                        _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    final user = Provider.of<UserState>(context ,listen: false).users;
    final sto = Provider.of<UserState>(context,listen: false).stock;
    final sup = Provider.of<UserState>(context,listen: false).supplier;
    final ord = Provider.of<CartState>(context, listen: false).oldorder;


    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[

            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.people_outline),
                              label: Text("Users"),
                          ),

                            subtitle : Text("${user.length}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.category),
                              label: Text("Stock")),
                        subtitle : Text("${sto.length}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.airport_shuttle_rounded),
                              label: Text("supplier")),
                        subtitle : Text("${sup.length}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.shopping_cart),
                              label: Text("Orders")),
                        subtitle : Text("${ord.length}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add stock"),
              onTap: () {
                _stockAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.widgets),
              title: Text("stock list"),
              onTap: () {
                _ListstockAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Add Users"),
              onTap: () {
                _usersAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.article_outlined),
              title: Text("Users list"),
              onTap: () {
                _ListUsersAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Add supplier"),
              onTap: () {
                _supplierAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.airport_shuttle_rounded),
              title: Text("supplier list"),
              onTap: () {
                _ListsupplierAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_forward_outlined),
              title: Text("logout"),
              onTap: () {
                _logoutnew();
              },
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _usersAlert() {
    var alert = new AlertDialog(
      content: Form(
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
              hintText: "Username",
            ),
            onSaved: (v) {
              _username = v;
            },
          ),
          TextFormField(
            validator: (v) {
              if (v.isEmpty) {
                return 'Enter Your email';
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
            onChanged: (v) {
              setState(() {
                _confpassword = v;
              });
            },
            onSaved: (v) {
              _password = v;
            },
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          TextFormField(
            validator: (v) {
              if (_confpassword != v) {
                return 'Confirm password';
              }
              if (v.isEmpty) {
                return 'Confirm Your password';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Confirm Password",
            ),
            onSaved: (v) {
              _password = v;
            },
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Enter Your role';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Role",
              ),
              onSaved: (v) {
                _role = v;
              },
            ),


          ],
      ),
    ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          _registerNow();
          }, child: Text('ADD')),
        FlatButton(onPressed: (){
          Navigator.pop(context);

          }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _supplierAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _supplierFormKey,
        child: Column(
            children: [
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Enter name supplier';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "name supplier",
                ),
                onSaved: (v) {
                  _name_s = v;
                },
              ),

              TextFormField(
                  decoration: InputDecoration(hintText: "phone"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Enter Your phone Number";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _phone= int.parse(v) ;
                  }
              ),
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Enter services';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "services",
                ),
                onSaved: (v) {
                  _services = v;
                },
              ),


            ],
        ),
      ),
      actions: <Widget>[

          FlatButton(
              onPressed: (){
                _addsupp();
              }, child: Text('ADD')
          ),
        FlatButton(onPressed: (){
          Navigator.pop(context);
          }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _ListUsersAlert() {

    final list = Provider.of<UserState>(context,listen: false).users;
    var alert = new AlertDialog(

      content: SingleChildScrollView(

            key: _userslistFormKey,

            child: Container(

              width: 845.6,
              height: 672.0,

              child:
              DataTable(

                     columns: [
                       DataColumn(label: Text("Username")),
                       DataColumn(label: Text("Email")),
                       DataColumn(label: Text("Role")),
                       DataColumn(label: Text("Action")),
                     ],

                rows: list.map((data) =>
                // we return a DataRow every time
                DataRow(
                    cells: [
                      DataCell(Text(data.username.toString() )),
                      DataCell(Text(data.email.toString() )),
                      DataCell(Text(data.role.toString() )),
                      DataCell(Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: Icon(Icons.edit_outlined),
                            onPressed: () {
                              // _deleteEmployee(employee);
                            },),

                        IconButton(icon: Icon(Icons.delete),
                          onPressed: () {
                            Provider.of<UserState>(context, listen: false).deleteuser(data.id);
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

  void _ListsupplierAlert() {

    final liste = Provider.of<UserState>(context,listen: false).supplier;
    var alert = new AlertDialog(

      content: SingleChildScrollView(

        key: _userslistFormKey,

        child: Container(

          width: 845.6,
          height: 672.0,

          child:
          DataTable(

            columns: [
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("phone ")),
              DataColumn(label: Text("services")),
              DataColumn(label: Text("Action")),
            ],

            rows: liste.map((data) =>
            // we return a DataRow every time
            DataRow(
                cells: [
                  DataCell(Text(data.name_s.toString() )),
                  DataCell(Text(data.phone.toString() )),
                  DataCell(Text(data.services.toString() )),
                  DataCell(Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.edit_outlined),
                        onPressed: () {

                        },),

                      IconButton(icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<UserState>(context, listen: false).deletesupplier(data.id);
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

  void _stockAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _stockFormKey,
        child: Column(
          children: [
            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Enter Article';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Article",
              ),
              onSaved: (v) {
                _Article = v;
              },
            ),

            TextFormField(
                decoration: InputDecoration(hintText: "quantite"),
                validator: (v) {
                  if (v.isEmpty) {
                    return "Enter Your phone Number";
                  }
                  return null;
                },
                onSaved: (v) {
                  _quantite = int.parse(v) ;
                }
            ),
            TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Enter categories';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "categories",
              ),
              onSaved: (v) {
                _categories = v;
              },
            ),


          ],
        ),
      ),
      actions: <Widget>[

        FlatButton(
            onPressed: (){
              _addstock();
            }, child: Text('ADD')
        ),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CANCEL')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _ListstockAlert() {

    final liste = Provider.of<UserState>(context,listen: false).stock;
    var alert = new AlertDialog(

      content: SingleChildScrollView(

        key: _stocklistFormKey,

        child: Container(

          width: 845.6,
          height: 672.0,

          child:
          DataTable(

            columns: [
              DataColumn(label: Text("Article")),
              DataColumn(label: Text("quantite ")),
              DataColumn(label: Text("categories")),
              DataColumn(label: Text("Action")),
            ],

            rows: liste.map((data) =>
            // we return a DataRow every time
            DataRow(
                cells: [
                  DataCell(Text(data.Article.toString() )),
                  DataCell(Text(data.quantite.toString() )),
                  DataCell(Text(data.categories.toString() )),
                  DataCell(Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.edit_outlined),
                        onPressed: () {

                        },),

                      IconButton(icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<UserState>(context, listen: false).deletestock(data.id);
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



}