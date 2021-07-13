import 'dart:convert';

import 'package:web_backoffice/Models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<List<User>> getUser() async {
    List<User> users = [];
    var url = Uri.parse(
        "http://www.json-generator.com/api/json/get/bPrqfgLraW?indent=2");
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else if (response.statusCode == 401) {
      throw new Exception("Invalid Token");
    }
    return users;
  }
}
