import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_app/LogSign/Login/Login.dart';
import 'package:police_app/LogSign/SignUp/Signup.dart';
import 'package:police_app/Navbar/nav_menu.dart';
import 'package:police_app/Pages/Home/Home.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Color(0xffDCF6E6),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: const AssetImage("assets/images/police4.png"), height: height * 0.6),
            Column(
              children: [
                Text("Build Awareness", style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600)),
                SizedBox(height: 10,),
                Text("Let's help our society with some help.",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center),
              ],
            ),
            Row(
              children: [
    //             Expanded(
    //               child: OutlinedButton(
    //                 onPressed: ()
    // async {try {
    //   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: "varun271203@example.com",
    //       password: "vcet@123"
    //   );
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }
    //                   Get.to(NavigationMenu());
    //                 },
    //                 child: Text("Login".toUpperCase()),
    //               ),
    //             ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {

                      Get.to(LoginScreen());
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                      padding: EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
                    ),
                    child: Text("Login".toUpperCase(),style: TextStyle(fontSize: 17),),
                  ),
                ),

                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
                      backgroundColor: Color(0xff4A8CB0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                    ),
                    onPressed: () {
                      Get.to(SignUpScreen());
                    },
                    child: Text("Signup".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 17),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}