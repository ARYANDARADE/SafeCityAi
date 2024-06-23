
import'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:police_app/Compo/NetwokManager.dart';
import 'package:police_app/Compo/full_screen_loader.dart';
import 'package:police_app/Compo/user_controller.dart';
import 'package:police_app/Compo/user_repo.dart';
import 'package:police_app/Profile/Profile.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance =>Get.find();

  final fullName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  //init user data when home appear
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //fetch user record
Future<void> initializeNames() async{
    fullName.text = userController.user.value.fullName;
}

Future<void> updateUserName() async{
    try{
      FullScreenLoader.openLoadingDialog('updating....','assets/images/SP.png');
      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
         FullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!updateUserNameFormKey.currentState!.validate()){
         FullScreenLoader.stopLoading();
        return;
      }
      //update username in FB
      Map<String, dynamic> name={'FullName':fullName.text.trim()};
      await userRepository.updateSingleField(name);

      //update
      //userController.user.value.fullName = fullName.text.trim();
      userController.user.update((val) {
        val?.fullName = fullName.text.trim();
      });

      FullScreenLoader.stopLoading();

      NetworkManager.successSnackBar(title: 'COngoooo',message: 'Name updated');

      Get.off(()=> ProfilePage());
      //Get.back();
    } catch(e){
      FullScreenLoader.stopLoading();
      NetworkManager.errorSnackBar(title: 'Oh snap name change',message: e.toString());
    }
}
}