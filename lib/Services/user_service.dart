import 'dart:convert';
import 'dart:html';

import 'package:web_backoffice/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:web_backoffice/constants.dart';
import 'package:web_backoffice/responsive.dart';

class UserService {
  static Future<List<User>> getUsers() async {
    List<User> users = [];
    var url = Uri.parse(
        baseURL+"/user/all");
    var response = await http.get(
      url,
      headers: {
    'Authorization': window.localStorage["token"]!,
    }
    );
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      users = await List<User>.from(jsonResponse.map((e) => User.fromJson(e))).toList();
    } else if (response.statusCode == 401) {
      throw new Exception("Invalid Token");
    }
    return users;
  }

  static Future<http.Response> addUser(User user) async {
    var url = Uri.parse(
        "${baseURL}auth/sign-up"
    );
    final message = await json.encode(user.toJson());
    print(message);
    var response = await http.post(url,
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //encoding: Encoding.getByName("utf-8"),
      body: message
    );
    if(response.statusCode == 500) {
      throw new Exception(
        "server error"
      );
    }
    return response;
  }

  static Future<http.Response> login({required String username, required String password}) async {
    var url = Uri.parse(baseURL+"auth/sign-in");
    return await http.post(url,
      headers:{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //encoding: Encoding.getByName("utf-8"),
      body: jsonEncode(<String, String> {
        'username': username,
        'password': password
      })
    );
  }

  static Future<http.Response> refreshToken() async{
    var url = Uri.parse(baseURL + 'auth/refresh-token');
    return http.get(url,
    headers: {
      'Authorization': window.localStorage["token"] ?? "empty"
    }
    );
  }

  static Future<http.Response> delete(User user) async {
    var url = Uri.parse(baseURL+'user/'+user.id.toString());
    return http.delete(url,
      headers:{
        'Authorization': window.localStorage["token"]!,
      },
    );
  }
}
