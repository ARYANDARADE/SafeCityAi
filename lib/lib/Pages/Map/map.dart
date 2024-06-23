import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _controller;
  late Location _location;
  late LatLng _initialCameraPosition;
  List<Marker> _markers = [];
  List<Marker>? _markers1 = [];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _location = Location();
    _initialCameraPosition = const LatLng(0.0, 0.0);
    _startTimer();
    // _getLocation(); // Default initial position
    // _fetchAndAddMarkers();

  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      LocationData locationData = await _location.getLocation();
      setState(() {
        _initialCameraPosition = LatLng(locationData.latitude!, locationData.longitude!);
        _markers= [
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _initialCameraPosition,
            infoWindow: const InfoWindow(title: 'Current Location'),
          ),
        ];
        // Update the marker for current location

      });
      _controller.animateCamera(
          CameraUpdate.newLatLngZoom(_initialCameraPosition, 15));
    } catch (e) {
      print("Error getting location: $e");
    }
  }
  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 20), (Timer timer) {
      _fetchAndAddMarkers();

    });
  }

  void _fetchAndAddMarkers() async {

    _markers1=null;
    LocationData locationData = await _location.getLocation();
    setState(() {
      _initialCameraPosition = LatLng(locationData.latitude!, locationData.longitude!);
      // Update the marker for current location
      _markers1= [
        Marker(
          markerId: MarkerId('currentLocation'),
          position: _initialCameraPosition,
          infoWindow: const InfoWindow(title: 'Current Location'),
        ),

      ];
      print(_markers1);
      print('========================location=================');
    });
    _controller.animateCamera(
        CameraUpdate.newLatLngZoom(_initialCameraPosition, 15));





    // Query Firestore to get data for each user
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('StreamData').get();

    // Loop through each document in the snapshot
    for (var doc in snapshot.docs) {
      // Extract latitude, longitude, and other data from the document

      double latitude = doc['latitude'];
      double longitude = doc['longitude'];
      LatLng location= LatLng(latitude, longitude);
      String markerId = doc['roomid'];
      String title = doc['title'];

      _markers1?.add(
        Marker(
          markerId: MarkerId(markerId),
          position: location,
          infoWindow: InfoWindow(title: title),
        ),
      );
      _markers=_markers1!;
      print(_markers);
      // Call _addMarker function to add marker for this user
      print('refreshed');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F1F21),
      appBar:  AppBar(
        backgroundColor:Color(0xff1F1F21),
        title: Text(
          'Map',
          style: TextStyle(fontSize: 20,
              color: Colors.white),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 15,
        ),
         markers: Set<Marker>.of(_markers),
       // onTap: Function to window(), // Add marker on tap
      ),
    );
  }
}
//
// void main() {
//   runApp(MaterialApp(
//     home: MapPage(),
//   ));
// }
// class MapPage extends StatefulWidget {
//   const MapPage({super.key});
//
//   @override
//
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   LatLng _initialCameraPosition = const LatLng(0.0, 0.0);
//
//   @override
//
//
//
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Page'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _initialCameraPosition,
//           zoom: 15,
//         ),
//         // markers: Set<Marker>.of(_markers),
//        // onTap: Function to window(), // Add marker on tap
//       ),
//     );
//   }
// }


//
// import 'package:location/location.dart';
//
// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   late GoogleMapController _controller;
//   late Location _location;
//   late LatLng _initialCameraPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _location = Location();
//     _initialCameraPosition = const LatLng(0.0, 0.0); // Default initial position
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     _controller = controller;
//     _getLocation();
//   }
//
//   Future<void> _getLocation() async {
//     try {
//       LocationData locationData = await _location.getLocation();
//       setState(() {
//         _initialCameraPosition = LatLng(locationData.latitude!, locationData.longitude!);
//       });
//       _controller.animateCamera(CameraUpdate.newLatLngZoom(_initialCameraPosition, 15));
//       return ;
//     } catch (e) {
//       print("Error getting location: $e");
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Page'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _initialCameraPosition,
//           zoom: 15,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('currentLocation'),
//             position: _initialCameraPosition,
//             infoWindow: const InfoWindow(title: 'Current Location'),
//           ),
//         },
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: MapPage(),
//   ));
// }
