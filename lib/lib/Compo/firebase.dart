import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

User? user = FirebaseAuth.instance.currentUser;

// Function to create a new document in the collection
void createDocument(String roomId, String title) async {
  LocationData? locationData = await getLocation();
  if (locationData != null) {
    try {
      await FirebaseFirestore.instance.collection('StreamData').doc(user?.uid).set({
        'UID': user?.uid,
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
        'roomId': roomId,
        'title': title,
      });
      print('Document created successfully!');
    } catch (e) {
      print('Error creating document: $e');
    }
  } else {
    print('Error getting location data');
  }
}

// Function to update a document in the collection
void updateDocument(Map<String, dynamic> dataToUpdate) async {
  try {
    await FirebaseFirestore.instance.collection('StreamData').doc(user?.uid).update(dataToUpdate);
    print('Document updated successfully!');
  } catch (e) {
    print('Error updating document: $e');
  }
}

// Function to delete a document from the collection
void deleteDocument() async {
  try {
    await FirebaseFirestore.instance.collection('StreamData').doc(user?.uid).delete();
    print('Document deleted successfully!');
  } catch (e) {
    print('Error deleting document: $e');
  }
}

Future<LocationData?> getLocation() async {
  Location location = Location();
  try {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  } catch (e) {
    print('Error getting location: $e');
    return null;
  }
}
