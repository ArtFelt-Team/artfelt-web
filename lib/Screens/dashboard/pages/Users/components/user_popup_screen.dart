import 'package:flutter/material.dart';

class UserPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 25.0),
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 7,
                  height: MediaQuery.of(context).size.width / 7,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Text("First Name"),
                Text("Last Name"),
                Text("Username"),
                Text("mail@mailmail.com"),
                Text("Adresse"),
                Text("First Name"),
              ],
            ),
          )),
    );
  }
}

// Widget userPopUP(BuildContext context) {
//   return new Dialog(
//       child: );
// }
