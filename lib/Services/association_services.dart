import 'dart:convert';
import 'dart:html';

import "package:http/http.dart" as http;
import 'package:web_backoffice/Models/Association.dart';
import 'package:web_backoffice/constants.dart';

class AssociationService {
  static Future<List<Association>> getAll() async {
    var url = Uri.parse(baseURL+'association/');
    List<Association> associations = [];
    var response = await http.get(url,
      headers:  {
    'Authorization': window.localStorage["token"]!,
    }
    );
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      associations = await List<Association>.from(jsonResponse.map((e) => Association.fromJson(e))).toList();
      print(jsonResponse);
    } else if (response.statusCode == 401) {
      throw new Exception("Invalid Token");
    }
    return associations;
  }
  static Future<http.Response> addAssociation(Association association) async {
    var url = Uri.parse(baseURL+'association/');
    var response =  json.encode(<String, String>{
      'name': association.name!,
      'description': association.description!,
      'IBAN': association.iban!,
      'BIC': association.bic!
    });
    return http.post(url,
      headers:{
        'Authorization': window.localStorage["token"]!,
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: response,
    );
  }
  static Future<http.Response> deleteAssociation(Association association) async {
    var url = Uri.parse(baseURL+'association/'+association.id.toString());
    return http.delete(url,
      headers:{
        'Authorization': window.localStorage["token"]!,
      },
    );
  }
}