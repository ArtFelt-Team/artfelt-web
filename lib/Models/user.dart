class User {
  final String? sId;
  final String? lastName;
  final String? firstName;
  final String? addressStreet;
  final String? addressCity;
  final String? adrressZipcode;
  final String? phoneNumber;
  final String? mail;
  final String? company;

  User(
      {this.sId,
      this.lastName,
      this.firstName,
      this.addressStreet,
      this.addressCity,
      this.adrressZipcode,
      this.phoneNumber,
      this.mail,
      this.company});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        sId: json['_id'],
        lastName: json['last_name'],
        firstName: json['first_name'],
        addressStreet: json['address_street'],
        addressCity: json['address_city'],
        adrressZipcode: json['adrress_zipcode'],
        phoneNumber: json['phone_number'],
        mail: json['mail'],
        company: json['company']);
  }
}
