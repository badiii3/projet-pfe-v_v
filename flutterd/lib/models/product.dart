class Product {
  int id;
  String title;
  String image;
  int Price;
  String description;
  Category category;

  Product(
      {this.id,
        this.title,
        this.image,
        this.Price,
        this.description,
        this.category,
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    Price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.Price;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}


class Category {
  int id;
  String title;

  Category({this.id, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Tables {

  int num;
  int capacite;

  Tables(
      {

        this.num,
        this.capacite,

      });

  Tables.fromJson(Map<String, dynamic> json) {

    num = json['num'];
    capacite = json['capacite'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['num'] = this.num;
    data['capacite'] = this.capacite;

    return data;
  }
}