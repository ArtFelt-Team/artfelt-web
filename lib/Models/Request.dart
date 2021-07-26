import 'dart:convert';

import 'package:web_backoffice/Models/user.dart';

class Request {
  final int? id;
  final String? type;
  final User? emitter;
  final String? message;
  final String? status;
  final String? creationDate;
  final String? updateDate;

  Request({this.id,
      this.type,
      this.message,
      this.emitter,
      this.status,
      this.creationDate,
      this.updateDate});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json["id"],
      type: json["type"],
      emitter: User.fromJson(json["emitter"]),
      message: json["message"],
      status: json["status"],
      creationDate: json["creation_date"],
      updateDate: json["last_updated_at"]
    );
  }


}