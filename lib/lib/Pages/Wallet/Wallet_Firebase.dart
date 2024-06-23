import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String? user = FirebaseAuth.instance.currentUser?.uid;




// Function to add wallet data

Future<void> addWalletData(String userID, int amount, List<Map<String, dynamic>> transactions) async {
  try {
    await FirebaseFirestore.instance.collection('Wallet').doc(userID).set({
      'UserID': userID,
      'Amount': amount,
      'Transactions': transactions,
    });
    print('Wallet data created successfully!');
  } catch (e) {
    print('Error creating wallet data: $e');
  }
}

// Function to add transaction data to a specific wallet


Future<void> addTransactionBetweenWallets( String receiverID, int amount) async {
  try {

    // Get sender's wallet data
    DocumentSnapshot senderSnapshot = await FirebaseFirestore.instance.collection('Wallet').doc(user).get();
    Map<String, dynamic> senderData = senderSnapshot.data() as Map<String, dynamic>;

    // Get receiver's wallet data
    DocumentSnapshot receiverSnapshot = await FirebaseFirestore.instance.collection('Wallet').doc(receiverID).get();
    Map<String, dynamic> receiverData = receiverSnapshot.data() as Map<String, dynamic>;

    // Check if sender has sufficient balance
    int senderBalance = senderData['Amount'];
    if (senderBalance < amount) {
      print('Sender does not have sufficient balance.');
      return;
    }

    // Update sender's wallet - debit amount
    await FirebaseFirestore.instance.collection('Wallet').doc(user).update({
      'Amount': senderBalance - amount,
      'Transactions': FieldValue.arrayUnion([
        {
          'TransactionType': 'debit',
          'Amount': amount,
          'Time': DateTime.now(),
          'ReceiverID': receiverID,
        }
      ]),
    });
    // Update receiver's wallet - credit amount
    await FirebaseFirestore.instance.collection('Wallet').doc(receiverID).update({
      'Amount': receiverData['Amount'] + amount,
      'Transactions': FieldValue.arrayUnion([
        {
          'TransactionType': 'credit',
          'Amount': amount,
          'Time': DateTime.now(),
          'SenderID': user,
        }
      ]),
    });

    print('Transaction completed successfully!');
    print('Transaction completed successfully!');

    print('Transaction completed successfully!');

  } catch (e) {
    print('Error completing transaction: $e');
  }
}
Future<void> initializeWalletsForAllUsers() async {
  try {
    // Retrieve all users from the "Users" collection
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();

    // Loop through each user and initialize their wallet if it doesn't exist
    for (QueryDocumentSnapshot userSnapshot in usersSnapshot.docs) {
      String userID = userSnapshot.id;
      await checkAndInitializeWallet(userID);
    }
  } catch (e) {
    print('Error initializing wallets for all users: $e');
  }
}

Future<void> checkAndInitializeWallet(String userID) async {
  try {
    // Check if the user's wallet exists
    DocumentSnapshot walletSnapshot = await FirebaseFirestore.instance.collection('Wallet').doc(userID).get();
    if (!walletSnapshot.exists) {
      // If wallet doesn't exist, initialize it
      await initializeWallet(userID);
    } else {
      print('User already has a wallet.');
    }
  } catch (e) {
    print('Error checking wallet: $e');
  }
}
// Example usage:
Future<void> initializeWallet(String userID) async {
  await addWalletData(
    userID,
    0,
    [],
  );
}
Future<String?> getUserIdFromUsername(String username) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('UserName', isEqualTo: username).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return null;
    }
  } catch (e) {
    print('Error fetching user ID: $e');
    return null;
  }
}