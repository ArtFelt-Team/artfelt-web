import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class RoutesNames {
  static String login = "/login";
  static String dashboard = "/";
  static String request = "/requests";
  static String users = "/users";
  static String shop = "/shop";
  static String profile = "/profile";
  static String association = "/associations";
}

const primaryColor = Color(0xFFFF63CA);
const secondaryColor = Color(0xff1b202a);
const bgColor = Color(0xFF0d1117);

const defaultPadding = 16.0;

const baseURL = "http://178.62.93.242:7701/v1/";
LocalStorage store = new LocalStorage('data.json');

class StatusEnum{
 static String pending = "PENDING";
 static String approved = "APPROUVED";
 static String declined = "DECLINED";
}