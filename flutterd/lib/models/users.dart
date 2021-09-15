class Users {
  int id;
  String username;
  String email;
  int role;

  Users(
      {
        this.id,
        this.username,
        this.email,
        this.role,
      });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['role'] = this.role;

    return data;
  }
}