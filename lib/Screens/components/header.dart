import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/Services/user_service.dart';

import '../../constants.dart';

class Header extends StatefulWidget {
  final String title;
  const Header({Key? key, required this.title}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();

}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    UserService.refreshToken().then((res) => {
      if(res.statusCode != 200) {
        window.localStorage.clear(),
        Navigator.pushNamed(context, RoutesNames.login)
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          color: secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  widget.title,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 50,
                    )
                  )
                ),
              ),
              Container(
                height: 50,
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(

                    textStyle: TextStyle(
                      color: Colors.white
                    )
                  ),
                  onPressed: () async {
                    window.localStorage.clear();
                    Navigator.pushNamed(context, RoutesNames.login);
                  },
                  child: Text(
                      "DISCONNECT",
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
