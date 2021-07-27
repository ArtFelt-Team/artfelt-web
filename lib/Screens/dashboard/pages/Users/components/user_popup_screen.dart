import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/Models/user.dart';
import 'package:web_backoffice/Services/user_service.dart';

import '../../../../../constants.dart';

class UserPopUp extends StatelessWidget {
  final User user;

  UserPopUp({Key? key, required this.user}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      //insetPadding: EdgeInsets.symmetric(horizontal: 400.0, vertical: 25.0),
      content: Container(
          width: MediaQuery.of(context).size.width / 3,
          //height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: MediaQuery.of(context).size.width/4,
                      maxHeight: MediaQuery.of(context).size.height/4,
                    ),
                    child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage:
                        NetworkImage(user.avatarURL ?? "https://via.placeholder.com/150"))
                ),
                buildTextRow(field: "Last Name:", data: user.lastName??"No Last Name Found"),
                buildTextRow(field: "First Name:", data: user.firstName??"No Last Name Found"),
                buildTextRow(field: "Username:", data: user.username??"No UsernameFound"),
                buildTextRow(field: "Mail:", data: user.mail??"No Mail Found"),
                buildTextRow(field: "Adress:", data: "${user.addressStreet}, ${user.addressCity}, ${user.adrressZipcode}"),

              ],
            ),
          )),
      actions: [
        InkWell(
          onTap: ()async{
            var response = await UserService.delete(user);
            if(response.statusCode == 204){
              if(user.id == window.localStorage["userID"]) {
                window.localStorage.clear();
                Navigator.pushNamed(context, RoutesNames.login);
              }
              print(response.statusCode);
              Navigator.pushNamed(context, RoutesNames.dashboard);
            } else {
              print(response.statusCode);
            }
          },
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Delete",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildTextRow({
    required String field,
    required String data
}) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    field,
                    style: GoogleFonts.lato(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    data,
                    style: GoogleFonts.lato(
                      fontSize: 25,
                    ),
                  ),
                ],
              );
  }
}

// Widget userPopUP(BuildContext context) {
//   return new Dialog(
//       child: );
// }
