import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_app/LogSign/Login/Login.dart';
import 'package:police_app/LogSign/Login/login_backend.dart';
class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () =>controller.googleSignIn(),
            icon: const Image(
              image: AssetImage('assets/images/google.png'),
              width: 20.0,
            ),
            label: Text('Sign-In with Google'.toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=>LoginScreen()),
            );
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "Already have an Account?",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(text: "Login".toUpperCase())
          ])),
        )
      ],
    );
  }
}