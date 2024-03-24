/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMode extends StatefulWidget {
  final String busNumber;

  DriverMode({required this.busNumber});

  @override
  _DriverModeState createState() => _DriverModeState();
}

class _DriverModeState extends State<DriverMode> {
  Location location = Location();
  LocationData? currentLocation;
  late GoogleMapController mapController;
  late Timer locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _getLocation();

    // Schedule location updates every 1 minute
    locationUpdateTimer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      _updateLocationInFirebase();
    });
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData result) {
      setState(() {
        currentLocation = result;
        _updateMapCamera();
      });
    });
  }

  void _updateLocationInFirebase() {
    if (currentLocation != null) {
      FirebaseFirestore.instance.collection('bus').doc(widget.busNumber).update({
        'latitude': currentLocation!.latitude,
        'longitude': currentLocation!.longitude,
        'timestamp': Timestamp.fromMillisecondsSinceEpoch(currentLocation!.time!.toInt()),
      });
    }
  }

  void _updateMapCamera() {
    if (mapController != null && currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    locationUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation?.latitude ?? 0.0,
            currentLocation?.longitude ?? 0.0,
          ),
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('busMarker'),
            position: LatLng(
              currentLocation?.latitude ?? 0.0,
              currentLocation?.longitude ?? 0.0,
            ),
            infoWindow: InfoWindow(title: 'Bus ${widget.busNumber}'),
          ),
        },
      ),
    );
  }
}
*/

/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMode extends StatefulWidget {
  final String busNumber;

  DriverMode({required this.busNumber});

  @override
  _DriverModeState createState() => _DriverModeState();
}

class _DriverModeState extends State<DriverMode> {
  Location location = Location();
  LocationData? currentLocation;
  late GoogleMapController mapController;
  late Timer locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _getLocation();

    // Schedule location updates every 10 seconds
    locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      _updateLocationInFirebase();
    });
  }


  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData result) {
      setState(() {
        currentLocation = result;
        _updateMapCamera();
      });
    });
  }

  void _updateLocationInFirebase() {
    if (currentLocation != null) {
      FirebaseFirestore.instance.collection('bus').doc(widget.busNumber).update({
        'latitude': currentLocation!.latitude,
        'longitude': currentLocation!.longitude,
        'timestamp': Timestamp.fromMillisecondsSinceEpoch(currentLocation!.time!.toInt()),
      });
    }
  }

  void _updateMapCamera() {
    if (mapController != null && currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    locationUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation?.latitude ?? 0.0,
            currentLocation?.longitude ?? 0.0,
          ),
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('busMarker'),
            position: LatLng(
              currentLocation?.latitude ?? 0.0,
              currentLocation?.longitude ?? 0.0,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: 'Bus ${widget.busNumber}'),
          ),
        },
      ),
    );
  }
}
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginRegisterPage.dart'; // Import your login/register page

class DriverMode extends StatefulWidget {
  final String busNumber;

  DriverMode({required this.busNumber});

  @override
  _DriverModeState createState() => _DriverModeState();
}

class _DriverModeState extends State<DriverMode> {
  Location location = Location();
  LocationData? currentLocation;
  late GoogleMapController mapController;
  late Timer locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _getLocation();

    // Schedule location updates every 10 seconds
    locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      _updateLocationInFirebase();
    });
  }

  Future<void> _getLocation() async {
    // Existing code...

    location.onLocationChanged.listen((LocationData result) {
      setState(() {
        currentLocation = result;
        _updateMapCamera();
      });
    });
  }

  void _updateLocationInFirebase() {
    if (currentLocation != null) {
      FirebaseFirestore.instance.collection('bus').doc(widget.busNumber).update({
        'latitude': currentLocation!.latitude,
        'longitude': currentLocation!.longitude,
        'timestamp': Timestamp.fromMillisecondsSinceEpoch(currentLocation!.time!.toInt()),
      });
    }
  }

  void _updateMapCamera() {
    if (mapController != null && currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
        ),
      );
    }
  }

  Future<void> _logout() async {
    // Clear the session when the user logs out
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate back to the login/register page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginRegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Mode'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation?.latitude ?? 0.0,
            currentLocation?.longitude ?? 0.0,
          ),
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('busMarker'),
            position: LatLng(
              currentLocation?.latitude ?? 0.0,
              currentLocation?.longitude ?? 0.0,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: 'Bus ${widget.busNumber}'),
          ),
        },
      ),
    );
  }
}
