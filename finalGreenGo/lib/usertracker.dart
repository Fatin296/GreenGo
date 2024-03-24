import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'RouteDetailsPage.dart';
import 'TrackingPage.dart';

class UserTracker extends StatelessWidget {
  final bool isLoggedIn;

  UserTracker({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is not authenticated
      return Scaffold(
        body: Center(
          child: Text('User not authenticated. Please log in.'),
        ),
      );
    }

    String uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Tracker'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Favourite Routes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserTracker(isLoggedIn: isLoggedIn)),
                );
              },
            ),
            ListTile(
              title: Text('All Routes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllRoutesPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favourites')
            .doc(uid)
            .collection('favourites')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(child: Text('No favourite routes available.'));
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var document = documents[index];
              var routeNo = document['routeNo'];

              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('bus')
                    .where('Route', isEqualTo: routeNo)
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> busSnapshot) {
                  if (busSnapshot.hasError) {
                    return Text('Error: ${busSnapshot.error}');
                  }

                  if (busSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  var busDocuments = busSnapshot.data!.docs;

                  if (busDocuments.isEmpty) {
                    return Text('No data available for route $routeNo');
                  }

                  var busNo = busDocuments[0]['Bus'];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackingPage(busNumber: busNo),
                        ),
                      );
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
                          'Route: $routeNo\nBus: ${busDocuments[0]['Bus']}\nFrom: ${busDocuments[0]['from']}\nTo: ${busDocuments[0]['to']}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class AllRoutesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Routes'),
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var route = document['Route'] ?? '';
              var from = document['from'] ?? '';
              var to = document['to'] ?? '';
              var busNo = document['Bus'] ?? '';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingPage(busNumber: busNo),
                    ),
                  );
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
                      'Route: $route\nBus: $busNo\nFrom: $from\nTo: $to',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
