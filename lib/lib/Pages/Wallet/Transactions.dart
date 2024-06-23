import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getUsersList() async {
  List<String> users = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').get();
    for (var doc in querySnapshot.docs) {
      // Assuming 'name' is a field in your user document
      String name = doc.get('UserName',);
      users.add(name);
    }
  } catch (e) {
    print('Error fetching users list: $e');
  }

  return users;
}

