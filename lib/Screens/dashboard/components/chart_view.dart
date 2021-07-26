import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_backoffice/Models/user.dart';

import '../../../constants.dart';

class ChartViewWidget extends StatelessWidget {
  final List<User> users;
   ChartViewWidget({
    Key? key, required this.users,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double moderatorCount = 0;
    double customerCount=0;
    double artistCount = 0;
    users.forEach((element) {
      if(element.role == 'MODERATOR'){
        moderatorCount++;
      } else if(element.role == 'ARTIST'){
        artistCount++;
      } else if(element.role == 'CUSTOMER'){
        customerCount++;
      }
    });

    moderatorCount = (moderatorCount/users.length)*100;
    customerCount = (customerCount/users.length)*100;
    artistCount = (artistCount/users.length)*100;

    return Card(
      color: secondaryColor,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              10)),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
                PieChartData(
                  sections: sections(
                    moderator: moderatorCount,
                    artist: artistCount,
                    customer: customerCount
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "Moderators"
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "Artists"
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "Customers"
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
double roundDouble(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

List<PieChartSectionData>? sections({required double moderator, required double customer, required double artist}) {
  return List.generate(3, (i) {
    final double radius = 50;
    final fontSize = 16.0;
    switch(i) {
      case 0:
        return PieChartSectionData(
          color:Colors.deepPurple,
          value: artist,
          title: "${roundDouble(artist, 2).toString()}%",
          radius: radius,
          titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.red,
          value: customer,
          title: "${roundDouble(customer, 2).toString()}%",
          radius: radius,
          titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: Colors.green,
          value: moderator,
          title: "${roundDouble(moderator, 2).toString()}%",
          radius: radius,
          titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      default:
        return PieChartSectionData(
          color: Colors.green,
          value: moderator,
          title: "${roundDouble(moderator, 2).toString()}%",
          radius: radius,
          //titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
    }
  });
}