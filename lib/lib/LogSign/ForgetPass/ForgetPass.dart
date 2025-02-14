import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:police_app/LogSign/ForgetPass/BottomSheet.dart';
import 'package:police_app/LogSign/ForgetPass/Mail.dart';
class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('"Make Selection!"',
                style: Theme.of(context).textTheme.headline2),
            Text('"Select one of the options given below to reset your password."',
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 30.0),
            ForgetPasswordBtnWidget(
              onTap: () {
                Get.back(); // Use Get.back instead of Navigator.pop
                Get.toNamed('/forget_password_mail');
              },
              title: 'Email',
              subTitle: 'Reset Via EMail',
              btnIcon: Icons.mail_outline_rounded,
            ),
            const SizedBox(height: 20.0),
            ForgetPasswordBtnWidget(
              onTap: () {},
              title: 'PhoneNo',
              subTitle: 'Reset Via Phone',
              btnIcon: Icons.mobile_friendly_rounded,
            ),
          ],
        ),
      ),
    );
  }
}