import 'package:flutter/material.dart';
import 'login.dart';
import 'options.dart';
import 'driver_login.dart'; // Import your driver login page file

class LoginRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/splash.png',
                  height: 200,
                ),
                SizedBox(height: 2),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyLogin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4BB93E),
                  ),
                  child: Text(
                    'Log In or Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Options(isLoggedIn: false)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4BB93E),
                  ),
                  child: Text(
                    'Using as a Guest',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriverLogin()), // Replace with your driver login page
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4BB93E),
                  ),
                  child: Text(
                    'Driver Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
