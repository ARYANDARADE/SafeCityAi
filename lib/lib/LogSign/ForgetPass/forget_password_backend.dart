import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:police_app/AuthenticationRepository.dart';
import 'package:police_app/Compo/NetwokManager.dart';
import 'package:police_app/Compo/full_screen_loader.dart';
import 'package:police_app/LogSign/ForgetPass/Mail.dart';
import 'package:police_app/LogSign/ForgetPass/Mail_Sent.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your request...',
          'assets/images/SP.png');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if(!forgetPasswordFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
      FullScreenLoader.stopLoading();

      NetworkManager.successSnackBar(title: 'Email sent', message: 'email sent to change your password');

      Get.to(()=>MailSent(email:email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();
      NetworkManager.errorSnackBar(title: 'reset Snap',message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your request...',
          'assets/images/SP.png');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      FullScreenLoader.stopLoading();

      NetworkManager.successSnackBar(title: 'Email sent', message: 'email sent to change your password');

    } catch (e) {
      FullScreenLoader.stopLoading();
      NetworkManager.errorSnackBar(title: 'reset Snap',message: e.toString());
    }
  }
}
