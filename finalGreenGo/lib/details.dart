// RouteDetailsPage.dart
import 'package:flutter/material.dart';

class RouteDetailsPage extends StatelessWidget {
  final String routeNumber;

  RouteDetailsPage({required this.routeNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Details'),
      ),
      body: Center(
        child: Text('Route Number: $routeNumber'),
      ),
    );
  }
}
