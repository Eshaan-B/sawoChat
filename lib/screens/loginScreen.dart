import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sawo/sawo.dart';

import 'chatScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = "/loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Sawo sawo = Sawo(
    apiKey: "9c62e0a3-84e4-49de-b53b-16146aa41223",
    secretKey: "614233f647fda11932859134ZzJR7pdwwWxS5A3vITM7M4Tg",
  );

  // user payload
  dynamic user;

  void test() {
    print("Test pressed");
    print(jsonDecode(user)["user_id"]);
  }

  void payloadCallback(context, payload) {
    if (payload == null || (payload is String && payload.length == 0)) {
      payload = "Login Failed :(";
    } else {
      setState(() {
        user = payload;
      });
      Navigator.of(context)
          .pushReplacementNamed(ChatScreen.routeName, arguments: {
        "uid": jsonDecode(user)["user_id"].toString(),
        "username":
            jsonDecode(user)["customFieldInputValues"]["username"].toString(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "UserData :- $user",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        onPressed: () async {
                          sawo.signIn(
                            context: context,
                            identifierType: 'phone_number_sms',
                            callback: payloadCallback,
                          );
                        },
                        child: Text(
                          'Phone Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
