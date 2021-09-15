class Supplier {
  int id;
  String name_s;
  int phone;
  String services ;

  Supplier(
      {
        this.id,
        this.name_s,
        this.phone,
        this.services,

      });

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name_s = json['name_s'];
    phone = json['phone'];
    services = json['services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_s'] = this.name_s;
    data['phone'] = this.phone;
    data['services'] = this.services;


    return data;
  }
}