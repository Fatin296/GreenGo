/*

import 'package:flutter/material.dart';
import 'driverMode.dart'; // Import the driver mode page

class DriverLogin extends StatefulWidget {
  @override
  _DriverLoginState createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Bus Number'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add your authentication logic here
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Check if the username is "bus" and the password is "123"
                if (password == "194271") {
                  // Navigate to the driver mode page and pass the bus number
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DriverMode(busNumber: username),
                    ),
                  );
                } else {
                  // Display an error message or handle authentication failure
                  print('Invalid credentials');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}


*/
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'driverMode.dart';

class DriverLogin extends StatefulWidget {
  @override
  _DriverLoginState createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Bus Number'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                // Add your authentication logic here
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Check if the username is "bus" and the password is "123"
                if (password == "194271") {
                  // Save the driver's session
                  await saveDriverSession(username);

                  // Navigate to the driver mode page and pass the bus number
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DriverMode(busNumber: username),
                    ),
                  );
                } else {
                  // Display an error message or handle authentication failure
                  print('Invalid credentials');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveDriverSession(String busNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('driverBusNumber', busNumber);
  }
}
