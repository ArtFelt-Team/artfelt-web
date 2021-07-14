import 'package:flutter/material.dart';
import 'package:web_backoffice/Controllers/user_service.dart';
import 'package:web_backoffice/Models/user.dart';
import 'package:web_backoffice/Screens/components/side_menu.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Users/components/user_popup_screen.dart';
import 'package:web_backoffice/constants.dart';
import 'package:web_backoffice/responsive.dart';

class DashboardScreen extends StatelessWidget {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
            child: SideMenu(),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.yellow,
                        )),
                    Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: UserList(users: users)),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.red,
                                )),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: FutureBuilder(
              future: UserService.getUser(),
              builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
                    return Text("Vous n'avez pas encore d'audit");
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Text("Vous n'avez pas encore d'audit");
                    }
                      return
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10)),
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder:
                                (BuildContext context,
                                int index) {
                              return InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) =>
                                          UserPopUp(),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                        Icons.person),
                                    title: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text((snapshot.data as dynamic)[index]?.lastName ?? " Last Name"),
                                        Text((snapshot.data as dynamic)[index].firstName ?? " First Name"),
                                        Text((snapshot.data as dynamic)[index].company ?? "Username"),
                                        Text((snapshot.data as dynamic)[index].mail ?? "mail"),
                                        Text((snapshot.data as dynamic)[index].phoneNumber ?? "Phone Number"),
                                      ],
                                    ),
                                  ));
                            }),
                      );
                    } else {
                   return CircularProgressIndicator();
                 }
              },
              ),
        ),
    );
  }
}
