/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:greengo_flutter/main.dart';

import 'LoginRegisterPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginRegisterPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildSplashImage(),
      ),
    );
  }

  Widget buildSplashImage() {
    try {
      return Image.asset('assets/images/splash.png');
    } catch (e) {
      print("Error loading image: $e");
      // Replace this with an error image or widget if needed
      return Text('Error loading image');
    }
  }
}
*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginRegisterPage.dart';
import 'Options.dart'; // Import your Options page file

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? Options(isLoggedIn: isLoggedIn,) : LoginRegisterPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildSplashImage(),
      ),
    );
  }

  Widget buildSplashImage() {
    try {
      return Image.asset('assets/images/splash.png');
    } catch (e) {
      print("Error loading image: $e");
      // Replace this with an error image or widget if needed
      return Text('Error loading image');
    }
  }
}
