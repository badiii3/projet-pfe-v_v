import 'package:flutter/cupertino.dart';

class OrderModel {
  int id;
  Table table;
  Cart cart;
  int etat;

  OrderModel({
    this.id,
    this.table,
    this.cart,

    this.etat,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    table = json['table']!= null ? new Table.fromJson(json['table']) : null;
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    etat = json['etat'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['etat'] = this.etat;

    if (this.table != null) {
      data['table'] = this.table.toJson();
    }

    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }


    return data;
  }
}

class Cart {
  int id;
  int total;
  bool isComplit;
  String date;
  int user;

  Cart({this.id, this.total, this.isComplit, this.date, this.user});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    isComplit = json['isComplit'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['isComplit'] = this.isComplit;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}

class Table {
  int id;
  int num;
  int capacite;

  Table({this.id,this.num, this.capacite});

  Table.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    capacite = json['capacite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['capacite'] = this.capacite;
    return data;
  }
}

class TableModel {
  int id;
  int num;
  int capacite;


  TableModel(
      {
        this.id,
        this.num,
        this.capacite,
        });

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    capacite = json['capacite'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['capacite'] = this.capacite;

    return data;
  }
}


class Cartproducts {
  int id;
  int price;
  int quantity;
  int subtotal;
  Cart cart;
  List<Product> product;

  Cartproducts(
      {this.id,
        this.price,
        this.quantity,
        this.subtotal,
        this.cart,
        this.product});

  Cartproducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int id;
  String title;
  String image;
  int Price;
  String description;
  int category;

  Product(
      {this.id,
        this.title,
        this.image,
        this.Price,
        this.description,
        this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    Price = json['price'];
    description = json['description'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.Price;
    data['description'] = this.description;
    data['category'] = this.category;
    return data;
  }
}