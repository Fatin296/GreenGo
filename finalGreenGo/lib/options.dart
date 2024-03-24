/*
import 'package:firebase_auth/firebase_auth.dart';

import 'LoginRegisterPage.dart';
import 'function.dart';
import 'FunctionPage.dart';
import 'package:flutter/material.dart';
import 'usertracker.dart';

class Options extends StatelessWidget {
  final bool isLoggedIn;

  const Options({required this.isLoggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back if the user is logged in
        return !isLoggedIn;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            if (isLoggedIn)  // Conditionally show the logout button
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  // Log out the user
                  await FirebaseAuth.instance.signOut();

                  // Navigate back to the login or home page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginRegisterPage()),
                  );
                },
              ),
          ],
        ),

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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLoggedIn) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserTracker(isLoggedIn: isLoggedIn)),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => function()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF4BB93E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 30),
                          ),
                          child: Text(
                            'Track Bus',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Adjust the spacing between buttons
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLoggedIn) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FunctionPage(isLoggedIn: isLoggedIn)),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => function()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF4BB93E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 30),
                          ),
                          child: Text(
                            'See Bus Schedule',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
*/


/*
import 'package:finalgreengo/GuestTrack.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'LoginRegisterPage.dart';
import 'function.dart';
import 'FunctionPage.dart';
import 'package:flutter/material.dart';
import 'usertracker.dart';

class Options extends StatelessWidget {
  final bool isLoggedIn;

  const Options({required this.isLoggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back if the user is logged in
        return !isLoggedIn;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            if (isLoggedIn)  // Conditionally show the logout button
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  // Log out the user
                  await FirebaseAuth.instance.signOut();

                  // Navigate back to the login or home page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginRegisterPage()),
                  );
                },
              ),
          ],
        ),

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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              if (isLoggedIn) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UserTracker(isLoggedIn: isLoggedIn)),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GuestTrack()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF4BB93E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            ),
                            child: Text(
                              'Track Bus',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Adjust the spacing between buttons
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10), // Added right margin
                          child: ElevatedButton(
                            onPressed: () {
                              if (isLoggedIn) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FunctionPage(isLoggedIn: isLoggedIn)),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => function()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF4BB93E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            ),
                            child: Text(
                              'See Bus Schedule',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
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
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'GuestTrack.dart';
import 'LoginRegisterPage.dart';
import 'function.dart';
import 'FunctionPage.dart';
import 'usertracker.dart';

class Options extends StatelessWidget {
  final bool isLoggedIn;

  const Options({required this.isLoggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // Log out the user
                await FirebaseAuth.instance.signOut();
                await clearPreferences();

                // Navigate back to the login or home page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginRegisterPage()),
                );
              },
            ),
        ],
      ),
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLoggedIn) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserTracker(isLoggedIn: isLoggedIn),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GuestTrack()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF4BB93E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          ),
                          child: Text(
                            'Track Bus',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLoggedIn) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FunctionPage(isLoggedIn: isLoggedIn),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => function()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF4BB93E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                          child: Text(
                            'See Bus Schedule',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),  // Adjust the spacing between buttons and Feedback button
                ElevatedButton(
                  onPressed: () async {
                    final String googleFormUrl = 'https://forms.gle/SEmQ7XsogvFTYYhS6';

                    // Open the URL in the default web browser
                    if (await canLaunchUrlString(googleFormUrl)) {
                      await launchUrlString(googleFormUrl);
                    } else {
                      // Handle the case where the URL can't be launched
                      print('Could not launch $googleFormUrl');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4BB93E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  child: Text(
                    'Feedback',
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

  Future<void> clearPreferences() async {
    // Clear the isLoggedIn key in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
}
