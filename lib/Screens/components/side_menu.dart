import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            child: Image.asset("images/logo.png"),
          ),
          DrawerListTile(
            title: "Home",
            svgSrc: "icons/menu_dashbord.svg",
            press: () {
              Navigator.pushReplacementNamed(context, RoutesNames.dashboard);
            },
          ),
          DrawerListTile(
            title: "Requests",
            svgSrc: "icons/menu_notification.svg",
            press: () {
              Navigator.pushReplacementNamed(context, RoutesNames.request);
            },
          ),
          DrawerListTile(
            title: "Store",
            svgSrc: "icons/menu_store.svg",
            press: () {
              Navigator.pushReplacementNamed(context, RoutesNames.artwork);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "icons/menu_profile.svg",
            press: () {
              Navigator.pushReplacementNamed(context, RoutesNames.profile);
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
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
