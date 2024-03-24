
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RouteDetailsPage extends StatelessWidget {
  final String routeNumber;

  RouteDetailsPage({required this.routeNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Details - $routeNumber'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Show bus picture in the middle
            Container(
              width: 100, // Adjust the width as needed
              height: 100, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bus.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Route-0$routeNumber').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                var documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return Text('No data available for route $routeNumber');
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: documents.map((document) {
                    var from = document['from'];
                    var pickTime = document['pickup_time'];

                    return Column(
                      children: [
                        Text(
                          '$from : $pickTime',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }).toList(),

                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
