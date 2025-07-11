import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usermanagersystem/components/logoImage.dart';
import 'package:usermanagersystem/components/signInSignUpButton.dart';
import 'package:usermanagersystem/components/textfield.dart';
import 'package:usermanagersystem/pages/authScreens/loginPage.dart';
import 'package:usermanagersystem/pages/home.dart';
import 'package:usermanagersystem/services/authServices.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _userLastNameTextController = TextEditingController();
  TextEditingController _userFirstNameTextController = TextEditingController();
  TextEditingController _userComfrimTextController = TextEditingController();
  TextEditingController _userPhoneNumberController = TextEditingController();

  Future<void> RegisterUser(
      String userName,
      String lastName,
      String firstName,
      String passwordd,
      String email,
      String confirmPassowrd,
      String phoneNumber) async {
    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "userName": userName,
      "password": passwordd,
      "confirmPassword": passwordd,
      "phoneNumber": phoneNumber
    };
    print(jsonEncode(body));
    var url = Uri.parse("http://140.82.25.196:8057/api/users/self-register");

    var headers = {
      'accept': 'application/json',
      'tenant': 'root',
      'Content-Type': 'application/json',
    };

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print(response);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 13, bottom: 15, right: 13, top: 45),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      "Manual ticketing system",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Best place for checking your glucose level  online .We ensure authentic products to our customer",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    reusableTextField("Enter UserName", Icons.person_outline,
                        false, _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter LastName", Icons.person_outline,
                        false, _userLastNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter FirstName", Icons.person_outline,
                        false, _userFirstNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline,
                        false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined,
                        true, _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Comfirm Password", Icons.lock_outlined,
                        true, _userComfrimTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Phone Number", Icons.lock_outlined, true,
                        _userPhoneNumberController),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        RegisterUser(
                            _userNameTextController.text,
                            _userLastNameTextController.text,
                            _userFirstNameTextController.text,
                            _emailTextController.text,
                            _passwordTextController.text,
                            _userComfrimTextController.text,
                            _userPhoneNumberController.text);
                      },
                      child: signInSignUpButton(context, false, () {}),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 19),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            " Login",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 19),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )));
  }
}
