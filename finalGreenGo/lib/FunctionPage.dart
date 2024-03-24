/* import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'RouteDetailsPage.dart'; // Import the RouteDetailsPage

class FunctionPage extends StatefulWidget {
  final bool isLoggedIn;

  FunctionPage({required this.isLoggedIn});

  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  List<bool> isFavoriteList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back if the user is logged in
        return !widget.isLoggedIn;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bus Details'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('bus').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Initialize isFavoriteList based on the number of items
            if (isFavoriteList.isEmpty) {
              isFavoriteList = List.generate(
                snapshot.data!.docs.length,
                    (index) => false,
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var busNumber = document['Bus'] ?? '';
                var route = document['Route'] ?? '';
                var from = document['from'] ?? '';
                var to = document['to'] ?? '';

                return GestureDetector(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      // If logged in, navigate to RouteDetailsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RouteDetailsPage(routeNumber: route),
                        ),
                      );
                    } else {
                      // Handle the case where the user is not logged in
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage('assets/images/bus.png'),
                      ),
                      title: Text(
                        'Route: $route\nFrom: $from\nTo: $to',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isFavoriteList[index] ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavoriteList[index] = !isFavoriteList[index];
                          });
                          // Add your logic for handling the love icon press
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
*/
/*
import 'package:finalgreengo/LoginRegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RouteDetailsPage.dart';
import 'favourites.dart';

class FunctionPage extends StatefulWidget {
  final bool isLoggedIn;

  FunctionPage({required this.isLoggedIn});

  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  List<bool> isFavoriteList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //return !widget.isLoggedIn;
        if (widget.isLoggedIn) {
          return true;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bus Details'),
          actions: [
            // Favorites Icon Button
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () async {

                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  String uid = user.uid;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => favourites(uid: uid),
                    ),
                  );
                } else {
                }
              },
            ),

            // Logout Icon Button
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // Log out the user
                await FirebaseAuth.instance.signOut();

                // Navigate back to the login or home page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginRegisterPage()), // Replace with the appropriate login/register page
                );
              },

            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('bus').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Initialize isFavoriteList based on the number of items
            if (isFavoriteList.isEmpty) {
              isFavoriteList = List.generate(
                snapshot.data!.docs.length,
                    (index) => false,
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                //var busNumber = document['Bus'] ?? '';
                var route = document['Route'] ?? '';
                var from = document['from'] ?? '';
                var to = document['to'] ?? '';

                return GestureDetector(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      // If logged in, navigate to RouteDetailsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RouteDetailsPage(routeNumber: route),
                        ),
                      );
                    } else {
                      // Handle the case where the user is not logged in
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage('assets/images/bus.png'),
                      ),
                      title: Text(
                        'Route: $route\nFrom: $from\nTo: $to',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isFavoriteList[index] ? Colors.red : Colors.grey,
                        ),
                        onPressed: () async {
                          // Get the current user
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            // If user is logged in, update the favorites collection
                            String uid = user.uid;

                            // Add your logic for handling the love icon press
                            String routeNo = route; // Change this based on your data

                            // Add or remove favorite based on the current state
                            if (isFavoriteList[index]) {
                              // Remove favorite
                              await FirebaseFirestore.instance
                                  .collection('favourites')
                                  .doc(uid)
                                  .collection('favourites')
                                  .doc(routeNo)
                                  .delete();
                            } else {
                              // Add favorite with both user ID and route number
                              await FirebaseFirestore.instance
                                  .collection('favourites')
                                  .doc(uid)
                                  .collection('favourites')
                                  .doc(routeNo)
                                  .set({
                                'uid': uid,
                                'routeNo': routeNo,
                              });
                            }

                            // Check if the route is a favorite for the current user
                            DocumentSnapshot favoriteSnapshot = await FirebaseFirestore.instance
                                .collection('favourites')
                                .doc(uid)
                                .collection('favourites')
                                .doc(routeNo)
                                .get();

                            setState(() {
                              // Update isFavoriteList based on whether the route is a favorite
                              isFavoriteList[index] = favoriteSnapshot.exists;
                            });
                          }
                        },
                      ),

                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
*/


/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginRegisterPage.dart';
import 'RouteDetailsPage.dart';
import 'favourites.dart';

class FunctionPage extends StatefulWidget {
  final bool isLoggedIn;

  FunctionPage({required this.isLoggedIn});

  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isLoggedIn) {
          return true;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bus Details'),
          actions: [
            // Favorites Icon Button
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  String uid = user.uid;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => favourites(uid: uid),
                    ),
                  );
                } else {
                  // Handle the case where the user is not logged in
                }
              },
            ),

            // Logout Icon Button
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('routes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var route = document['Route'] ?? '';
                var from = document['from'] ?? '';
                var to = document['to'] ?? '';

                return GestureDetector(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      // If logged in, navigate to RouteDetailsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteDetailsPage(routeNumber: route),
                        ),
                      );
                    } else {
                      // Handle the case where the user is not logged in
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/bus.png'),
                      ),
                      title: Text(
                        'Route: $route\nFrom: $from\nTo: $to',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: FutureBuilder<bool>(
                        future: isFavorite(route),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Icon(Icons.favorite, color: Colors.grey);
                          } else {
                            bool isFavorite = snapshot.data ?? false;
                            return IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () async {
                                bool success = await toggleFavorite(route);
                                if (success) {
                                  setState(() {});
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<bool> isFavorite(String route) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot favoriteSnapshot = await FirebaseFirestore.instance
          .collection('favourites')
          .doc(uid)
          .collection('favourites')
          .doc(route)
          .get();
      return favoriteSnapshot.exists;
    }
    return false;
  }

  Future<bool> toggleFavorite(String route) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot favoriteSnapshot = await FirebaseFirestore.instance
          .collection('favourites')
          .doc(uid)
          .collection('favourites')
          .doc(route)
          .get();

      if (favoriteSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection('favourites')
            .doc(uid)
            .collection('favourites')
            .doc(route)
            .delete();
        return false;
      } else {
        await FirebaseFirestore.instance
            .collection('favourites')
            .doc(uid)
            .collection('favourites')
            .doc(route)
            .set({
          'uid': uid,
          'routeNo': route,
        });
        return true;
      }
    }
    return false;
  }
}
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginRegisterPage.dart';
import 'RouteDetailsPage.dart';
import 'favourites.dart';

class FunctionPage extends StatefulWidget {
  final bool isLoggedIn;

  FunctionPage({required this.isLoggedIn});

  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isLoggedIn) {
          return true;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bus Details'),
          actions: [
            // Favorites Icon Button
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  String uid = user.uid;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => favourites(uid: uid),
                    ),
                  );
                } else {
                  // Handle the case where the user is not logged in
                }
              },
            ),

            // Logout Icon Button
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('routes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var route = document['Route'] ?? '';
                var from = document['from'] ?? '';
                //var to = document['to'] ?? '';

                return GestureDetector(
                  onTap: () {
                    if (widget.isLoggedIn) {
                      // If logged in, navigate to RouteDetailsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteDetailsPage(routeNumber: route),
                        ),
                      );
                    } else {
                      // Handle the case where the user is not logged in
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/bus.png'),
                      ),
                      title: Text(
                        'Route: $route\nFrom: $from\nTo: Campus',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: FutureBuilder<bool>(
                        future: isFavorite(route),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Icon(Icons.favorite, color: Colors.grey);
                          } else {
                            bool isFavorite = snapshot.data ?? false;
                            return IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () async {
                                if (widget.isLoggedIn) {
                                  bool success = await toggleFavorite(route);
                                  if (success) {
                                    setState(() {});
                                  }
                                } else {
                                  // Handle the case where the user is not logged in
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<bool> isFavorite(String route) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot favoriteSnapshot = await FirebaseFirestore.instance
          .collection('favourites')
          .doc(uid)
          .collection('favourites')
          .doc(route)
          .get();
      return favoriteSnapshot.exists;
    }
    return false;
  }

  Future<bool> toggleFavorite(String route) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot favoriteSnapshot = await FirebaseFirestore.instance
          .collection('favourites')
          .doc(uid)
          .collection('favourites')
          .doc(route)
          .get();

      if (favoriteSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection('favourites')
            .doc(uid)
            .collection('favourites')
            .doc(route)
            .delete();
        return false;
      } else {
        await FirebaseFirestore.instance
            .collection('favourites')
            .doc(uid)
            .collection('favourites')
            .doc(route)
            .set({
          'uid': uid,
          'routeNo': route,
        });
        return true;
      }
    }
    return false;
  }

  Future<void> clearPreferences() async {
    // Clear the isLoggedIn key in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
}


