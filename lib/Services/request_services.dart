import 'dart:convert';
import 'dart:html';

import "package:http/http.dart" as http;
import 'package:web_backoffice/Models/Request.dart';
import 'package:web_backoffice/constants.dart';
class RequestService {
  static Future<List<Request>> getAll() async {
    List<Request> requests = [];
    var url = Uri.parse(baseURL+'request/');
    var response = await http.get(url,
    headers: {
      'Authorization': window.localStorage["token"]!,
    }
    );
    if(response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      requests = await List<Request>.from(jsonResponse.map((e) => Request.fromJson(e))).toList();
    } else {
      throw new Exception("Invalid Token");
    }
    return requests;
  }
  
  static Future<http.Response> updateArtistStatus(Request request, String message) async {
    var url = Uri.parse(baseURL+'request/'+request.id!.toString());
    return await http.post(url,
      headers:  {
        'Authorization': window.localStorage["token"]!,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
          'message': message,
        })
    );
  }
}