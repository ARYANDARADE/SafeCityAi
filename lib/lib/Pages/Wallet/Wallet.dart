import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:police_app/Pages/Wallet/Transactions.dart';
import 'package:police_app/Pages/Wallet/Wallet_Firebase.dart';

import 'Wallet_Transactions.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String? userID = FirebaseAuth.instance.currentUser?.uid;



  @override
  void initState() {
    super.initState();
    initializeWalletsForAllUsers();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor:Color(0xff1F1F21),
        title: const Text('Wallet',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 15,bottom: 15,left: 30,right: 30),
                backgroundColor: Color(0xff4A8CB0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80,vertical: 5),
                child:Text('Send Badges',style: TextStyle(color: Colors.white,fontSize: 15),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
