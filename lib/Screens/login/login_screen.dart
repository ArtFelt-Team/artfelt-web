import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:web_backoffice/Services/user_service.dart';
import 'package:web_backoffice/constants.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            Expanded(
              flex:2,
              child: SvgPicture.asset(
                "login_image.svg",
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "Login",
                      fillColor: secondaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
            Padding(padding: EdgeInsets.only(top: defaultPadding)),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: defaultPadding)),
              TextButton(
                onPressed: () async {
                  var response =  await UserService.login(username: _usernameController.text, password: _passwordController.text);
                  var body  = jsonDecode(response.body);
                  print(response.statusCode);
                  if(response.statusCode == 200) {
                    print(body["token"]);
                    print(body["user"]);
                    print("I'm in");
                    window.localStorage.addAll(<String, String>{
                      "token":body["token"],
                    });
                    print(window.localStorage["token"]);
                    Navigator.pushNamed(context, RoutesNames.dashboard);
                  }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                width: MediaQuery.of(context).size.width / 8,
                height: MediaQuery.of(context).size.width / 40,
                child: Text(
                  "LOGIN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: Colors.white,
                    fontSize: 28
                  ),
                ),
              ))
          ],
        ),
      ),
      ]),
      ),
      ),
    );
  }
}
