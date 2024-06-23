import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:police_app/LogSign/SignUp/Form.dart';
import 'package:police_app/Profile/update_name_controller.dart';
import 'package:police_app/Update_Phoneno/update_phoneno_controller.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhonenoController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Change ChangePhoneno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Use your real Phoneno',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            SizedBox(height: 16,),
            Form(
              key: controller.updateUserPhoneNoFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phoneNo,
                    validator: (value)=>Validator.validatePhoneNumber(value),
                    expands: false,
                    decoration: InputDecoration(labelText:'ChangePhoneno',prefixIcon: Icon(Iconsax.user)),
                  ),
                  SizedBox(height: 24,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()=>controller.updateUserPhoneNo(),
                      child: (
                          Text('Save',)
                      ),
                    ),
                  )
                ],
              ),)
          ],
        ),
      ),
    );
  }
}
