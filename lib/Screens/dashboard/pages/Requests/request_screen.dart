import 'package:flutter/material.dart';
import 'package:web_backoffice/Screens/components/side_menu.dart';

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        body: Row(
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Center(
                  child: Text("Request Screen"),
                ),
              ),
            ),
          ],
        ));
  }
}
