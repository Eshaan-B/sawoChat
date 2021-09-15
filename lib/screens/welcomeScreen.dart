import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = ColorTween(begin: Colors.amber, end: Colors.amberAccent[100])
        .animate(controller!);
    animation!.addStatusListener((listener) {
      if (listener == AnimationStatus.completed)
        controller!.reverse();
      else if (listener == AnimationStatus.dismissed) controller!.forward();
    });
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void navigate(String screen) {
    if (screen == "chats")
      Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                  ),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/images/sawoFullLogo.png'),
                      height: 70.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: AnimatedTextKit(
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      pause: Duration(milliseconds: 50),
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'SAWO_Chat',
                          speed: Duration(milliseconds: 50),
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TypewriterAnimatedText(
                          'Simplyfing Auth',
                          speed: Duration(milliseconds: 50),
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
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
                            onPressed: () {
                              navigate('chats');
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              "Let's go!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Hope you like it :)',
                          speed: Duration(milliseconds: 50),
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Made by: Eshaan Bhardwaj",
                    style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
