import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_backoffice/Screens/components/header.dart';
import 'package:web_backoffice/Screens/components/side_menu.dart';
import 'package:web_backoffice/constants.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        body: Row(children: [
          Expanded(
            child: SideMenu(),
          ),
          Expanded(
            flex: 5,
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Header(title: "Store Dashboard"),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("Top 10 Selling"),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(10, (index) {
                                  return Card(
                                    color: secondaryColor,
                                    child: InkWell(
                                      onTap: (){},
                                      child: Container(
                                        width: 100,
                                        child: Column(
                                            children: [
                                              FaIcon(FontAwesomeIcons.trophy, color: Colors.yellow[700],),
                                              Text("#${index+1}"),
                                              Text("Title"),
                                              Text("By this Author"),
                                            ]),
                                      ),
                                    ),
                                  );
                                })),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          child: Text("Second section"),
                        ))
                  ],
                ),
              ),
            ]),
          ),
        ]));
  }
}
