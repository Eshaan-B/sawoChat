import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName="splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Image.asset('assets/images/sawoFullLogo.png'),),
      ),
    );
  }
}
