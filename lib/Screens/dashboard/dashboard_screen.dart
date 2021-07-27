import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/Models/user.dart';
import 'package:web_backoffice/Screens/components/header.dart';
import 'package:web_backoffice/Screens/components/side_menu.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Users/components/new_user_popup_screen.dart';
import 'package:web_backoffice/Screens/dashboard/pages/Users/components/user_popup_screen.dart';
import 'package:web_backoffice/Services/user_service.dart';
import 'package:web_backoffice/constants.dart';

import 'components/chart_view.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                        child: Header(title: "User dashboard"),
                        ),
                    Expanded(
                        flex: 7,
                        child: FutureBuilder<List<User>>(
                          future: UserService.getUsers(),
                          builder: (context, AsyncSnapshot snapshot) {
                            switch(snapshot.connectionState){
                              case ConnectionState.waiting:
                                return buildWaitingWidget();
                                break;
                              case ConnectionState.done:
                                if(snapshot.hasData == false || snapshot.data == []){
                                  return Center(
                                    child: Card(
                                      color: secondaryColor,
                                      child: Text("No Data received from remote API",
                                      style: GoogleFonts.lato(
                                        fontSize: 50,
                                      ),),
                                    ),
                                  );
                                }
                                return Row(
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: UserFutureBuilder(users: snapshot.data)),
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: ChartViewWidget(users: snapshot.data,),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Card(
                                                    color: secondaryColor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                    child: Container(),
                                                  ))
                                            ],
                                          ),
                                        )),
                                  ],
                                );
                                break;
                              default:
                                return Container();
                            }
                          }
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

  Row buildWaitingWidget() {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: CircularProgressIndicator()),
        Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Card(
                        color: secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10)),
                        child: Container(),
                      ))
                ],
              ),
            )),
      ],
    );
  }
}


class UserFutureBuilder extends StatefulWidget {
  final List<User> users;
  UserFutureBuilder({
    Key? key,
    required this.users,
  }) : super(key: key);


  @override
  _UserFutureBuilderState createState() => _UserFutureBuilderState(users);
}

class _UserFutureBuilderState extends State<UserFutureBuilder> {
  _UserFutureBuilderState(this.users);
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*Row(
                  children: [
                    ListActionInkwell(
                      color: Colors.green,
                      buttonText: "All",
                      onTap: (){},
                    ),
                    SizedBox(width: 10),
                    ListActionInkwell(
                        color: Colors.blue,
                        buttonText: "Customers",
                        onTap: (){}),
                    SizedBox(width: 10),
                    ListActionInkwell(
                        color: Colors.orangeAccent,
                        buttonText: "Artists",
                        onTap: () {}),
                    SizedBox(width: 10),
                    ListActionInkwell(
                        color: Colors.red,
                        buttonText: "Moderators",
                        onTap: () {}),
                  ],
                ),*/
                ListActionInkwell(
                    color: Colors.green,
                    buttonText: "Add User",
                    onTap: (){
                      showDialog(
                        context: context,
                        builder:
                            (context) => AddUserPopUpForm(),
                      );
                    })
              ],
            ),
          ),
        ),
        Expanded(
          flex: 15,
          child: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  color: secondaryColor,
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
                                    (context) => UserPopUp(user: users[index]),
                              );
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.only(bottom: 16.0),
                              leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 64,
                                    maxHeight: 64,
                                  ),
                                  child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                      NetworkImage(users[index].avatarURL ?? "https://via.placeholder.com/150"))
                              ),
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Text(users[index].lastName ?? " Last Name"),
                                  Text(users[index].firstName ?? " First Name"),
                                  Text(users[index].username ?? "Username"),
                                  Text(users[index].mail ?? "mail"),
                                  Text(users[index].role ?? "role"),
                                ],
                              ),
                            ));
                      }),
                )
              ),
          ),
        ),
      ],
    );
  }
}

class ListActionInkwell extends StatelessWidget {
  final Color color;
  final String buttonText;
  final Function() onTap;
  const ListActionInkwell({
    Key? key, required this.color, required this.buttonText, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}