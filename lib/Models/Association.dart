
import 'package:web_backoffice/Models/user.dart';

class Association {
  final int? id;
  final String? name;
  final String? description;
  final String? iban;
  final String? bic;
  //final Array<User>? donators;

  Association(
      {this.id,
      this.name,
      this.description,
      this.iban,
      this.bic,
      });

  factory Association.fromJson(Map<String, dynamic>json){
    return Association(
      id: json["id"],
      name: json["name"],
      bic: json["BIC"],
      iban: json["IBAN"],
      description: json["description"]
    );
  }
}