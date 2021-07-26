import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/Models/Association.dart';
import 'package:web_backoffice/Screens/components/header.dart';
import 'package:web_backoffice/Screens/components/side_menu.dart';
import 'package:web_backoffice/Services/association_services.dart';
import 'package:web_backoffice/constants.dart';

class AssociationScreen extends StatelessWidget {
  const AssociationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                child: Header(title: "Association dashboard"),
                ),
                Expanded(
                flex: 7,
                  child: FutureBuilder<List<Association>>(
                        future: AssociationService.getAll(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch(snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Card(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                              break;
                            case ConnectionState.done:
                              if(snapshot.hasData == false || snapshot.data == []){
                                return Card(
                                  child: Text(
                                    "No data received",
                                    style: GoogleFonts.lato(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                );
                              } else if(snapshot.hasError) {
                                return Card(
                                  child: Text(
                                      "${snapshot.error}",
                                    style: GoogleFonts.lato(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                );
                              }
                              return Column(
                                children: [
                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              _showNewAssociationDialog(context);
                                            },
                                            child: Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Add Association",
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                            ),
                                         ),
                                        ],
                                      )),
                                  Expanded(
                                    flex:15,
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
                                                itemCount: snapshot.data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return InkWell(
                                                      onTap: () {
                                                        _showAssociationDialog(context, snapshot.data[index]);
                                                      },
                                                      child: ListTile(
                                                        contentPadding: EdgeInsets.only(bottom: 16.0),
                                                        leading: FaIcon(FontAwesomeIcons.storeAlt),
                                                        title: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Text(snapshot.data[index].name ?? " Last Name"),
                                                            Text(snapshot.data[index].iban ?? " First Name"),
                                                            Text(snapshot.data[index].bic ?? "Username"),
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
                              break;
                            default:
                              return Container();
                          }
                        },
                      ),
                )
                ]
              ),
            ),
          ],
        ));
  }
}
Future<void> _showNewAssociationDialog(BuildContext context) async {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _ibanController = new TextEditingController();
  final TextEditingController _bicController = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  return showDialog(context: context, builder: (context){
    return AlertDialog(
        backgroundColor: secondaryColor,
        title: Text("Add Association",
          style: GoogleFonts.lato(

          ),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width/4,
          height: MediaQuery.of(context).size.height/4,
          child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Insert name"
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          hintText: "Insert description"
                      ),
                    ),
                    TextFormField(
                      controller: _ibanController,
                      decoration: InputDecoration(
                          hintText: "Insert IBAN"
                      ),
                    ),
                    TextFormField(
                      controller: _bicController,
                      decoration: InputDecoration(
                          hintText: "Insert BIC"
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
        actions: [
          InkWell(
            onTap: ()async{
              Association  asso =  new Association(
                name: _nameController.text,
                description: _descriptionController.text,
                iban: _ibanController.text,
                bic: _bicController.text
              );
              var response = await AssociationService.addAssociation(asso);
              print(response.statusCode);
              if(response.statusCode == 201) {
                Navigator.pop(context);
              } else if (response.statusCode == 401) {

              }
            },
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Add",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
            ),
          )
      ],
    );
  });
}

Future<void> _showAssociationDialog(BuildContext context, Association association) async {
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      backgroundColor: secondaryColor,
      title: Text("${association.name}",
        style: GoogleFonts.lato(

        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width/4,
        height: MediaQuery.of(context).size.height/4,
        child:  Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("IBAN:"),
                      Text("${association.iban}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("BIC: "),
                      Text("${association.bic}"),
                    ],
                  ),
                  Text("${association.description}")
                ],
              ),
            )
        ),
      actions: [
        /*InkWell(
          onTap: ()async{
          },
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Add",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
          ),
        ),*/
        InkWell(
          onTap: ()async{
            var response = await AssociationService.deleteAssociation(association);
            if(response.statusCode == 204){
              Navigator.pushNamed(context, RoutesNames.association);
            } else {

            }
          },
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Delete",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
          ),
        )
      ],
    );
  });
}
