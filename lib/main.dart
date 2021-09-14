import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
                : ChatScreen(),
            routes: {
              SplashScreen.routeName: (ctx) => SplashScreen(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
            },
          );
        });
  }
}
