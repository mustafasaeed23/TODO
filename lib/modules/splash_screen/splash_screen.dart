import 'dart:async';

import 'package:flutter/material.dart';

import '../../layout/home.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 2), () {
       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(223, 236, 219, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              "assets/images/logo_splash_screen.png",
            ),
            Spacer(),
            Image.asset(
              "assets/images/main_splash_screen.png",
            ),
          ],
        ));
  }
}
