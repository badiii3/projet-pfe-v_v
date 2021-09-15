import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import '../models/product.dart';

import 'package:http/http.dart' as http;

class ProductState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');
    List<Product> _products = [];
    List<Tables> _table = [];
    List<Category> _category = [];


  Future<bool> getProducts() async {
    String url = 'http://127.0.0.1:8000/api/products/';
    var token = storage.getItem('token');
    try {
      http.Response response =
          await http.get(url, headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      // print(data);
      List<Product> temp = [];
      data.forEach((element) {
        Product product = Product.fromJson(element);
        temp.add(product);
      });
      _products = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e getProducts");
      print(e);
      return false;
    }
  }



  Future<bool> addProducts(String title,int Price,String image,String description) async {
    String url = 'http://127.0.0.1:8000/api/products/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"title": title,"Price": Price,"image": image,"description": description,}));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e add Products ");
      print(e);
      return false;
    }
  }

  Future<void> deleteProduct(int id) async {
    String url = 'http://127.0.0.1:8000/api/products/$id/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      if (response.statusCode == 200) {
        return Category.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("e delete Product");
      print(e);

    }
  }


  Future<bool> addTables(int num, int capacite) async {
    String url = 'http://127.0.0.1:8000/api/table/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"num": num, "capacite": capacite }));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e add table ");
      print(e);
      return false;
    }
  }



  Future<bool> gettable() async {
    String url = 'http://127.0.0.1:8000/api/table/';
    var token = storage.getItem('token');
    try {
      http.Response response =
      await http.get(url, headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      //print(data);
      List<Tables> temp = [];
      data.forEach((element) {
        Tables table = Tables.fromJson(element);
        temp.add(table);
      });
      _table = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e stock");
      print(e);
      return false;
    }
  }

  Future<void> deletetable(int num) async {
    String url = 'http://127.0.0.1:8000/api/table/$num/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token",
          });

      if (response.statusCode == 200) {
        return Tables.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("e delete table");
      print(e);

    }
  }


  Future<bool> addCategory(String title) async {
    String url = 'http://127.0.0.1:8000/api/category/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"title": title}));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e add category ");
      print(e);
      return false;
    }
  }


  Future<bool> UpdateCategory(int id ,String title) async {
    String url = 'http://127.0.0.1:8000/api/category/$id/';
    try {
      http.Response response = await http.put(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"title": title}));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e update category ");
      print(e);
      return false;
    }
  }

  Future<bool> getCategory() async {
    String url = 'http://127.0.0.1:8000/api/category/';
    var token = storage.getItem('token');
    try {
      http.Response response =
      await http.get(url, headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      //print(data);
      List<Category> temp = [];
      data.forEach((element) {
        Category category = Category.fromJson(element);
        temp.add(category);
      });
      _category = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e Category");
      print(e);
      return false;
    }
  }

  Future<void> deleteCategory(int id) async {
    String url = 'http://127.0.0.1:8000/api/category/$id/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      if (response.statusCode == 200) {
        return Category.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("e delete Category");
      print(e);

    }
  }



  List<Tables> get table {
    return [..._table];
  }


  List<Category> get category {
    return [..._category];
  }


  List<Product> get poducts {
    return [..._products];
  }



  Product singleProduct(int id) {
    return _products.firstWhere((element) => element.id == id);
  }



}