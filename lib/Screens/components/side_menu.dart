import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_backoffice/constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("images/artfelt-logo-transparent-light.png"),
          ),
          DrawerListTile(
            title: "Home",
            icon: FaIcon(FontAwesomeIcons.user),
            press: () {
              Navigator.pushNamed(context, RoutesNames.dashboard);
            },
          ),
          DrawerListTile(
            title: "Requests",
            icon: FaIcon(FontAwesomeIcons.paperPlane),
            press: () {
              Navigator.pushNamed(context, RoutesNames.request);
            },
          ),
          /*DrawerListTile(
            title: "Store",
            icon: FaIcon(FontAwesomeIcons.store),
            press: () {
              Navigator.pushNamed(context, RoutesNames.shop);
            },
          ),*/
          DrawerListTile(
            title: "Associations",
            icon: FaIcon(FontAwesomeIcons.store),
            press: () {
              Navigator.pushNamed(context, RoutesNames.association);
            },
          ),
          DrawerListTile(
            title: "Profile",
            icon: FaIcon(FontAwesomeIcons.userCircle),
            press: () {
              Navigator.pushNamed(context, RoutesNames.profile);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final FaIcon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
