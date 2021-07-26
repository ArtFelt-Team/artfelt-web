import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_backoffice/Models/user.dart';
import 'package:web_backoffice/Services/user_service.dart';

import '../../../../../constants.dart';

class AddUserPopUpForm extends StatefulWidget {
  const AddUserPopUpForm({Key? key}) : super(key: key);

  @override
  _AddUserPopUpFormState createState() => _AddUserPopUpFormState();
}

class _AddUserPopUpFormState extends State<AddUserPopUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();
  final TextEditingController _cityController = new TextEditingController();
  final TextEditingController _zipcodeController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _firstNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: secondaryColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 400.0, vertical: 25.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Add new User",
                style: GoogleFonts.lato(
                  fontSize: 30,
                ),
              ),
              buildUsernameFormField(),
              buildLastNameFormField(),
              buildFirstNameFormField(),
              buildPasswordFormField(),
              buildMailFormField(),
              buildAdressFormField(),
              buildCityFormField(),
              buildZipCodeFormField(),
              ElevatedButton(onPressed: () async {
                var user = new User(
                  username: _usernameController.text,
                  lastName: _lastNameController.text,
                  firstName: _firstNameController.text,
                  password: _passwordController.text,
                  mail: _emailController.text,
                  addressCity: _cityController.text,
                  addressStreet: _addressController.text,
                  adrressZipcode: _zipcodeController.text,
                  role: "MODERATOR",
                );

                if (_formKey.currentState!.validate()) {
                  var response = await UserService.addUser(user);
                  print(response);
                  switch (response.statusCode) {
                    case 201:
                      print(response.statusCode);
                      const SnackBar(
                          content: Text('Moderator added'),
                        backgroundColor: Colors.green,
                      );
                      Navigator.pushNamed(context, RoutesNames.dashboard);
                      break;
                    case 400:
                      print(response.statusCode);
                      const SnackBar(
                        content: Text('Invalid form'),
                        backgroundColor: Colors.red,
                      );
                      break;
                    case 404:
                      print(response.statusCode);
                      const SnackBar(
                        content: Text('Ressource not found'),
                        backgroundColor: Colors.red,
                      );
                      break;
                  }
                }
              }, child: Text("Submit"))
            ],
          )),
    );
  }

  TextFormField buildZipCodeFormField() {
    return TextFormField(
              controller: _zipcodeController,
              decoration: InputDecoration(
                hintText: "Zip Code",
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: "city",
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }

  TextFormField buildAdressFormField() {
    return TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: "address",
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }

  TextFormField buildMailFormField() {
    return TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "mail",
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                hintText: "First Name",
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                hintText: "Last Name",
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "username",
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            );
  }
}
