import 'package:flutter/material.dart';
import 'package:web_backoffice/Screens/components/side_menu.dart';
import 'package:web_backoffice/constants.dart';
import 'package:web_backoffice/responsive.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            if(Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Container(),
            ),
          ],
        )
      ),
    );
  }
}