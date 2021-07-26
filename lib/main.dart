import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/Models/Association.dart';
import 'package:web_backoffice/Screens/dashboard/dashboard_screen.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Artworks/artwork_screen.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Association/association_screen.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Profile/profile_screen.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Requests/request_screen.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Users/user_screen.dart';
import 'package:web_backoffice/Screens/login/login_screen.dart';
import 'package:web_backoffice/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: RoutesNames.dashboard,
      routes: {
        RoutesNames.login: (context) => LoginScreen(),
        RoutesNames.dashboard: (context) => DashboardScreen(),
        RoutesNames.request: (context) => RequestScreen(),
        RoutesNames.shop: (context) => ShopScreen(),
        RoutesNames.users: (context) => UserScreen(),
        RoutesNames.profile: (context) => ProfileScreen(),
        RoutesNames.association: (context) => AssociationScreen()
      },
    );
  }
}
