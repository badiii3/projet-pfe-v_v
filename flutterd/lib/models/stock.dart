class Stock {
  int id;
  String Article;
  int quantite;
  String categories ;

  Stock(
      {
        this.id,
        this.Article,
        this.quantite,
        this.categories,

      });

  Stock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Article = json['Article'];
    quantite = json['quantite'];
    categories = json['categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Article'] = this.Article;
    data['quantite'] = this.quantite;
    data['categories'] = this.categories;


    return data;
  }
}