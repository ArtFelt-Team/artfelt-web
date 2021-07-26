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
const secondaryColor = Color(0xFF6C73F6);
const bgColor = Color(0xFFFFFFFF);

const defaultPadding = 16.0;

const baseURL = "http://192.168.1.31:7701/v1/";
LocalStorage store = new LocalStorage('data.json');