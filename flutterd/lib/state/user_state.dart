import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterd/screens/Admin.dart';
import 'package:flutterd/screens/home_Screens.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../models/users.dart';
import '../models/supplier.dart';
import '../models/stock.dart';


class UserState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');
  LocalStorage rolestorage = new LocalStorage('role');

  List<Users> _users = [];



  List<Supplier> _supplier = [];
  Supplier _Supplier;


  List<Stock> _stock = [];
  Stock _Stock;


  Future<bool> loginNow(String email, String passw) async {
    String url = 'http://127.0.0.1:8000/api/login/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"email": email, "password": passw}));
      var data = json.decode(response.body) as Map;

      if (data.containsKey("token") && (data.containsKey("email"))) {
        storage.setItem("token", data['token']);
        rolestorage.setItem("role", data['role']);
        print(storage.getItem('token'));
        print(rolestorage.getItem('role'));
        return true;
      }

      return false;
    } catch (e) {
      print("e loginNow");
      print(e);
      return false;
    }
  }

  Future<bool> registernow(String uname, String passw ,String email ,String role) async {
    String url = 'http://127.0.0.1:8000/api/register/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"username": uname, "password": passw ,"email":email , "role":role }));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e loginNow");
      print(e);
      return false;
    }
  }

  Future<bool> getUsers() async {
    String url = 'http://127.0.0.1:8000/api/users/';
    var token = storage.getItem('token');
    try {
      http.Response response =
      await http.get(url, headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
       //print(data);
      List<Users> temp = [];
      data.forEach((element) {
        Users users = Users.fromJson(element);
        temp.add(users);
      });
      _users = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e users");
      print(e);
      return false;
    }
  }


  Future<void> deleteuser(int id) async {
    String url = 'http://127.0.0.1:8000/api/users/$id/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      if (response.statusCode == 200) {
        return Users.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("e delete users");
      print(e);

    }
  }



  Future<bool> addSupplier(String name_s, int phone ,String services) async {
    String url = 'http://127.0.0.1:8000/api/supplier/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"name_s": name_s, "phone": phone ,"services":services }));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e add supplier ");
      print(e);
      return false;
    }
  }

  Future<bool> getSupplier() async {
    String url = 'http://127.0.0.1:8000/api/supplier/';
    var token = storage.getItem('token');
    try {
      http.Response response =
      await http.get(url, headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      //print(data);
      List<Supplier> temp = [];
      data.forEach((element) {
        Supplier supplier = Supplier.fromJson(element);
        temp.add(supplier);
      });
      _supplier = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e supplier");
      print(e);
      return false;
    }
  }


  Future<void> deletesupplier(int id) async {
    String url = 'http://127.0.0.1:8000/api/supplier/$id/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      if (response.statusCode == 200) {
        return Supplier.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("e delete Supplier");
      print(e);

    }
  }



  Future<bool> addStock(String Article, int quantite ,String categories) async {
    String url = 'http://127.0.0.1:8000/api/stock/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"Article": Article, "quantite": quantite ,"categories":categories }));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e add stock ");
      print(e);
      return false;
    }
  }

  Future<bool> getStock() async {
    String url = 'http://127.0.0.1:8000/api/stock/';
    var token = storage.getItem('token');
    try {
      http.Response response =
      await http.get(url, headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      //print(data);
      List<Stock> temp = [];
      data.forEach((element) {
        Stock stock = Stock.fromJson(element);
        temp.add(stock);
      });
      _stock = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e stock");
      print(e);
      return false;
    }
  }


  Future<void> deletestock(int id) async {
    String url = 'http://127.0.0.1:8000/api/stock/$id/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      if (response.statusCode == 200) {
        return Stock.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("e delete Stock");
      print(e);

    }
  }





  List<Stock> get stock {
    return [..._stock];
  }

  List<Users> get users {
    return [..._users];
  }

  List<Supplier> get supplier {
    return [..._supplier];
  }


}
