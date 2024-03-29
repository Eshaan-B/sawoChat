import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/welcomeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/chatScreen.dart';
import 'screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : WelcomeScreen(),
            routes: {
              SplashScreen.routeName: (ctx) => SplashScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
            },
          );
        });
  }
}
