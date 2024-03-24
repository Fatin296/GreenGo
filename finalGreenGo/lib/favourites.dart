
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'RouteDetailsPage.dart';

class favourites extends StatefulWidget {
  final String uid;

  favourites({required this.uid});

  @override
  _favouritesState createState() => _favouritesState();
}

class _favouritesState extends State<favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Routes'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favourites')
            .doc(widget.uid)
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

                  if (busSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  var busDocuments = busSnapshot.data!.docs;

                  if (busDocuments.isEmpty) {
                    return Text('No data available for route $routeNo');
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteDetailsPage(routeNumber: routeNo),
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
                          'Route: $routeNo\nFrom: ${busDocuments[0]['from']}\nTo: Campus',
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
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favourites extends StatefulWidget {
  final String uid;

  Favourites({required this.uid});

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Routes'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favourites')
            .doc(widget.uid)
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

                  if (busSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  var busDocuments = busSnapshot.data!.docs;

                  if (busDocuments.isEmpty) {
                    return Text('No data available for route $routeNo');
                  }

                  // Display the details of the route
                  var routeDetails = busDocuments
                      .map((busDocument) => busDocument['routeDetails'])
                      .toList();

                  return ListTile(
                    title: Text('Route: $routeNo'),
                    subtitle: Text('Details: ${routeDetails.join(', ')}'),
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
*/