/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingPage extends StatefulWidget {
  final String busNumber;

  TrackingPage({required this.busNumber});

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  Location location = Location();
  LocationData? currentLocation;
  late GoogleMapController mapController;
  late Timer locationUpdateTimer;
  StreamSubscription<LocationData>? locationSubscription;

  Set<Marker> markers = {}; // Set to store markers on the map

  @override
  void initState() {
    super.initState();
    _getLocation();

    // Schedule location updates every 1 minute
    locationUpdateTimer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      _updateLocationInFirebase();
      _updateMapMarkers();
    });
  }

  Future<void> _getLocation() async {
    // Check for location services
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check for location permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Listen for location changes
    locationSubscription = location.onLocationChanged.listen((LocationData result) {
      if (mounted) {
        setState(() {
          currentLocation = result;
          _updateMapCamera();
        });
      }
    });
  }

  void _updateLocationInFirebase() {
    if (currentLocation != null) {
      FirebaseFirestore.instance
          .collection('bus')
          .doc(widget.busNumber)
          .update({
        'latitude': currentLocation!.latitude,
        'longitude': currentLocation!.longitude,
        'timestamp': Timestamp.fromMillisecondsSinceEpoch(currentLocation!.time!.toInt()),
      });
    }
  }

  void _updateMapMarkers() {
    FirebaseFirestore.instance
        .collection('bus')
        .doc(widget.busNumber)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        var busData = snapshot.data() as Map<String, dynamic>;
        double busLatitude = busData['latitude'];
        double busLongitude = busData['longitude'];

        // Update the bus marker on the map
        updateBusMarker(busLatitude, busLongitude);
      }
    });
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

  void updateBusMarker(double busLatitude, double busLongitude) {
    setState(() {
      markers.clear(); // Clear all markers
      markers.add(
        Marker(
          markerId: MarkerId('busMarker'),
          position: LatLng(busLatitude, busLongitude),
          infoWindow: InfoWindow(title: 'Bus ${widget.busNumber}'),
        ),
      );

      // Add user's current location marker
      if (currentLocation != null) {
        markers.add(
          Marker(
            markerId: MarkerId('userMarker'),
            position: LatLng(currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
            infoWindow: InfoWindow(title: 'Your Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    locationUpdateTimer.cancel();

    // Cancel the location update subscription
    locationSubscription?.cancel();

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
        markers: markers,
      ),
    );
  }
}
*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackingPage extends StatefulWidget {
  final String busNumber;

  TrackingPage({required this.busNumber});

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  Location location = Location();
  LocationData? currentLocation;
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      // Check for location services
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      // Check for location permission
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      // Listen for location changes
      location.onLocationChanged.listen((LocationData result) {
        setState(() {
          currentLocation = result;
          _updateMap();
        });
      });
    } catch (e) {
      print('Error: $e');
    }
  }
/*
  Future<void> _fetchRandomLocationData() async {
    try {
      // Access Firestore collection 'bus'
      QuerySnapshot busSnapshot = await FirebaseFirestore.instance
          .collection('bus')
          .where('Bus', isEqualTo: widget.busNumber)
          .get();

      // Check if there's at least one document
      if (busSnapshot.docs.isNotEmpty) {
        // Get the first document (assuming there's only one matching bus number)
        var busData = busSnapshot.docs.first.data();

        // Check for null and type before accessing properties
        if (busData != null && busData is Map<String, dynamic>) {
          // Extract latitude and longitude
          double busLatitude = busData['latitude'] ?? 0.0;
          double busLongitude = busData['longitude'] ?? 0.0;

          // Add destination location marker
          markers.add(
            Marker(
              markerId: MarkerId('destinationMarker'),
              position: LatLng(busLatitude, busLongitude),
              infoWindow: InfoWindow(title: 'Bus Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          );
        }
      } else {
        print('No matching documents for bus number ${widget.busNumber}');
      }
    } catch (e) {
      print('Error fetching bus location: $e');
    }
  }
*/
  Future<void> _fetchRandomLocationData() async {
    try {
      // Access Firestore collection 'bus'
      QuerySnapshot busSnapshot = await FirebaseFirestore.instance
          .collection('bus')
          .where('Bus', isEqualTo: widget.busNumber)
          .get();

      // Check if there's at least one document
      if (busSnapshot.docs.isNotEmpty) {
        // Get the first document (assuming there's only one matching bus number)
        var busData = busSnapshot.docs.first.data();

        // Check for null and type before accessing properties
        if (busData != null && busData is Map<String, dynamic>) {
          // Extract latitude and longitude
          double busLatitude = busData['latitude'] ?? 0.0;
          double busLongitude = busData['longitude'] ?? 0.0;

          // Add bus icon to replace marker
          markers.add(
            Marker(
              markerId: MarkerId('busMarker'),
              position: LatLng(busLatitude, busLongitude),
              infoWindow: InfoWindow(title: 'Bus Location'),
              icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(40, 40)),
                'assets/images/bus_icon.png',
              ),
            ),
          );
        }
      } else {
        print('No matching documents for bus number ${widget.busNumber}');
      }
    } catch (e) {
      print('Error fetching bus location: $e');
    }
  }

  void _updateMap() {
    if (mapController != null && currentLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
        ),
      );

      // Add user's current location marker
      markers.add(
        Marker(
          markerId: MarkerId('userMarker'),
          position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          infoWindow: InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      // Fetch random location data from Firestore
      _fetchRandomLocationData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Page'),
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
        markers: markers,
      ),
    );
  }
}

