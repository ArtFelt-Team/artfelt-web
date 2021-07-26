class User {
  final String? id;
  final String? lastName;
  final String? firstName;
  final String? username;
  final String? password;
  final String? addressStreet;
  final String? addressCity;
  final String? adrressZipcode;
  final String? mail;
  final String? role;


  User(
      {
        this.id,
      this.lastName,
      this.firstName,
      this.username,
        this.password,
      this.addressStreet,
      this.addressCity,
      this.adrressZipcode,
      this.mail,
      this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        lastName: json['last_name'],
        firstName: json['first_name'],
        username: json['username'],
        password: json['password'],
        mail: json['mail'],
        addressStreet: json['address_street'],
        addressCity: json['address_city'],
        adrressZipcode: json['address_zip_code'],
        role: json['role']);
  }
  Map<String, dynamic> toJson() {
    return <String, String?>{
      'last_name': lastName,
      'first_name': firstName,
      'username': username,
      'password': password,
      'mail': mail,
      'address_street': addressStreet,
      'address_city': addressCity,
      'address_zip_code': adrressZipcode,
      'role': role
    };
  }
}
