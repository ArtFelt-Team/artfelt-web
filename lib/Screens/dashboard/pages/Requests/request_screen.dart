import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/Models/Request.dart';
import 'package:web_backoffice/Screens/components/header.dart';
import 'package:web_backoffice/Screens/components/side_menu.dart';
import 'package:web_backoffice/Services/request_services.dart';
import 'package:web_backoffice/constants.dart';

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
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Header(
                          title: 'Requests',
                        )),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                            width: double.infinity, child: RequestListView()),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}

class RequestListView extends StatefulWidget {
  const RequestListView({Key? key}) : super(key: key);

  @override
  _RequestListViewState createState() => _RequestListViewState();
}

class _RequestListViewState extends State<RequestListView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: FutureBuilder<List<Request>>(
        future: RequestService.getAll(),
        builder: (context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState) {
            case ConnectionState.done:
              if(snapshot.hasData == false || snapshot.data == []){
                return Center(
                  child: Text("No data available"),
                );
              }
              if(snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              if(snapshot.hasData){
                return SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Row(
                            children: [Text("Type")],
                          )),
                      DataColumn(label: Text("Emitter")),
                      DataColumn(label: Text("Message")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Action"))
                    ],
                    rows: requestRows(context,snapshot.data),
                  ),
                );
              }
              else {
                return Container();
              }
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              return Container(
                child: CircularProgressIndicator(),
              );
          }
        },
      )
    );
  }
}

List<DataRow> requestRows( BuildContext context,List<Request> requests) {
  FaIcon icon= FaIcon(FontAwesomeIcons.paintBrush);
  Color color = Colors.orangeAccent;
  List<DataRow> rows = [];
  requests.forEach((element) {
    if(element.type == 'ARTIST_REQUEST') {
      icon = FaIcon(FontAwesomeIcons.paintBrush);
    } else if(element.type == 'BANK_INFO_REQUEST') {
      icon = FaIcon(FontAwesomeIcons.dollarSign);
    } else {
      icon = FaIcon(FontAwesomeIcons.question);
    }
    if(element.status == 'PENDING') {
     color = Colors.orangeAccent;
    } else if(element.status == 'DECLINED') {
      color = Colors.red[700]!;
    } else {
      color = Colors.green;
    }
    rows.add(DataRow(
        cells: [
      DataCell(icon),
      DataCell(Text(element.emitter!.username!)),
      DataCell(Text(element.message!)),
      DataCell(
          Text(element.status!,
            style: GoogleFonts.lato(
              color: color
            ),
          )
      ),
      DataCell(
        TextButton(
          onPressed: (){
            _showCustomDialog(context: context,request: element);
          },
          child: Text("Take Action",
          style: GoogleFonts.lato(
            color: Colors.white
          ),),
        )
      )
    ]));
  });
  return rows;
}

Future<void> _showCustomDialog({required BuildContext context, required Request request}) async{
  return showDialog(
      context: context,
      builder: (BuildContext context){
        final String type;
        if(request.type == 'BANK_INFO_REQUEST'){
          type = 'Bank information request';
        } else{
          type = 'In App Status request';
        }
        return AlertDialog(
          backgroundColor: secondaryColor,
          title: Text(
            '${request.emitter!.username}: $type',
          ),
          content: Container(
            width: MediaQuery.of(context).size.width/2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${request.creationDate}"),
                    Text("${request.status}"),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  child: Container(

                    child: Text(
                      "${request.message}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            InkWell(
                onTap: () async {
                  var response = await RequestService.updateArtistStatus(request, StatusEnum.approved);
                  if(response.statusCode == 200){
                    Navigator.pushNamed(context, RoutesNames.request);
                  }
                },
                child: Container(
                  child: (Text(
                    "Approve",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  )),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  width: MediaQuery.of(context).size.width/10,
                )),
            InkWell(
                onTap: () async {
                  var response = await RequestService.updateArtistStatus(request, StatusEnum.declined);
                  if(response.statusCode == 200){
                    Navigator.pushNamed(context, RoutesNames.request);
                  }
                },
                child: Container(
                  child: (Text(
                    "Decline",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  )),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  width: MediaQuery.of(context).size.width/10,
                )),
          ],
        );
      });
}
