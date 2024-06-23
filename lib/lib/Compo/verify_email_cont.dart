import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_app/AuthenticationRepository.dart';
import 'package:police_app/Compo/NetwokManager.dart';
import 'package:police_app/LogSign/SignUp/success_screen.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      NetworkManager.successSnackBar(
          title: 'Email sent',
          message: 'Check your email inbox and verify your email');
    } catch (e) {
      NetworkManager.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(()=>const SuccessScreen(),);
      }
    });
  }

  checkEmailVerificationStatus() async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser !=null && currentUser.emailVerified){
      Get.off(
          ()=>const SuccessScreen(),
      );
    }
  }
}
