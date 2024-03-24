/*
import 'package:flutter/material.dart';

class function extends StatelessWidget {
  final List<String> items = List<String>.generate(20, (index) => "Bus $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add margin for spacing between list items
            padding: EdgeInsets.all(16), // Add padding to the container
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Add border to the container
              borderRadius: BorderRadius.circular(12), // Add border radius to the container
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/bus.png'),
              ),
              title: Text(
                items[index],
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Add your onTap logic here
              },
            ),
          );
        },
      ),
    );
  }
}
*/

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class function extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var busNumber = document['Bus'] ?? '';
              var route = document['Route'] ?? '';
              var from = document['from'] ?? '';
              var to = document['to'] ?? '';

              return Container(
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
                    'Bus $busNumber\nRoute: $route\nFrom: $from\nTo: $to',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    // Add your onTap logic here
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'RouteDetailsPage.dart';

class function extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
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
              //var busNumber = document['Bus'] ?? '';
              var route = document['Route'] ?? '';
              var from = document['from'] ?? '';
             // var to = document['to'] ?? '';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RouteDetailsPage(routeNumber: route),
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
                      'Route: $route\nFrom: $from\nTo: Campus',
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
