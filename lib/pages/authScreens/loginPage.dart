import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usermanagersystem/components/signInSignUpButton.dart';
import 'package:usermanagersystem/components/textfield.dart';
import 'package:usermanagersystem/models/matchevents.dart';
import 'package:usermanagersystem/pages/allmatchevents.dart';
import 'package:usermanagersystem/pages/allticket.dart';
import 'package:usermanagersystem/pages/authScreens/registerPage.dart';
import 'package:http/http.dart' as http;
import 'package:usermanagersystem/pages/home.dart';
import 'package:usermanagersystem/services/tokenStore.dart';

import '../../models/loginresponse.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> LoginrUser(
      String email,
      String passwordd,
    ) async {
      var body = {
        "email": email,
        "password": passwordd,
      };
      print(jsonEncode(body));
      var url = Uri.parse("http://140.82.25.196:8057/api/tokens");

      var headers = {
        'accept': 'application/json',
        'tenant': 'root',
        'Content-Type': 'application/json',
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print(response);
      if (response.statusCode == 200) {
        TokenStore tokenStore = TokenStore();

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        ReturnOrder returnOrder = ReturnOrder.fromMap(jsonResponse);

        tokenStore.setToken(returnOrder.token);
        print(tokenStore.token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TicketsAll()),
        );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

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
                    const SizedBox(height: 10),
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
                        false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordTextController),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        LoginrUser(_emailTextController.text,
                            _passwordTextController.text);
                      },
                      child: Text(
                        'LOG IN',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue;
                            }
                            return const Color.fromARGB(255, 94, 176, 243);
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I dont have an account ",
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
                                  builder: (context) => AllMatchEvents()),
                            );
                          },
                          child: Text(
                            " SignUp",
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
