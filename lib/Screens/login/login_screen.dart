import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/constants.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _loginController = new TextEditingController();
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
                    controller: _loginController,
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
                onPressed: () => {
                  Navigator.pushNamed(context, RoutesNames.dashboard)
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
