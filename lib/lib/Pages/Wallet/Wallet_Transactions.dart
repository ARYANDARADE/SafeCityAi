import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Pages/Wallet/Transactions.dart';
import 'package:police_app/Pages/Wallet/Wallet_Firebase.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? receiverID;
  int? amount;

  String? _selectedUser;
  List<String> _usersList = [];

  Future<void> _fetchUsersList() async {
    List<String> users = await getUsersList();
    setState(() {
      _usersList = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsersList();
  }
  Future<void> _onConfirmTransaction() async {
    if (_selectedUser != null && amount != null) {
      // Convert selected username to user ID
      String? userID = await getUserIdFromUsername(_selectedUser!);
      if (userID != null) {
        await addTransactionBetweenWallets(userID, amount!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction completed successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a user and enter amount!')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.black26,
      appBar: AppBar(
        backgroundColor:Color(0xff1F1F21),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text('Make Transaction',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedUser,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUser = newValue;
                  receiverID = null; // Set the receiver ID when dropdown value changes
                });
              },
              items: _usersList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Color(0xff4A8CB0)), // Set text color to white
                  ),
                );
              }).toList(),
              hint: const Text('Select a user',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
            ),
            const SizedBox(height: 20),
            // Text field to enter the amount
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                labelStyle: TextStyle(color: Colors.white), // Set label text color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white), // Set border color
                ),
                prefixIcon: Icon(Icons.currency_rupee, color: Colors.white), // Set icon color
              ),
              style: TextStyle(color: Colors.white), // Set input text color
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = int.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onConfirmTransaction,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 15,bottom: 15,left: 30,right: 30),
                backgroundColor: Color(0xff4A8CB0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60,vertical: 5),
                child:Text('Confirm Transaction',style: TextStyle(color: Colors.white,fontSize: 15),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
