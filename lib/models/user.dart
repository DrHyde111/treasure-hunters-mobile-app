class User {
  int _id;
  String email;
  String name;
  String role;

  User(this._id, this.email, this.name, this.role);

  User.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        email = json['email'],
        name = json['name'],
        role = json['role'];
}
