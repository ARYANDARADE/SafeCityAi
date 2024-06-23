//import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_app/Compo/profile_menu.dart';
import 'package:police_app/Compo/user_controller.dart';
import 'package:police_app/LogSign/Welcome.dart';
import 'package:police_app/Profile/ChangeName.dart';
import 'package:police_app/Update_Phoneno/ChangePhoneno.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    Key? key,
    this.isNetworkImage = false,
  }) : super(key: key);

  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return Scaffold(
      backgroundColor: Color(0xff1F1F21),
      appBar: AppBar(
        // Add a tooltip for accessibility
        backgroundColor:Color(0xff1F1F21),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          color: Color(0xff4A8CB0),
        ),
        title: Text('Profile',style: TextStyle(color: Color(0xff4A8CB0)),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : 'assets/images/profile.png';
                      return Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100,),
                          child: Center(
                            child: networkImage.isNotEmpty
                                ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: image,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                                : Image(
                              fit: BoxFit.cover,
                              image: isNetworkImage
                                  ? NetworkImage(image)
                                  : AssetImage(image) as ImageProvider,
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: Text("Change profile picture"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Profile information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:Color(0xff4A8CB0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => ChangeName()),
              ),
              ProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () {},
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              Row(
                children: [
                  Text(
                    "Personal information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4A8CB0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              ProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                icon: Icons.copy,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNo,
                onPressed: () => Get.to(() => ChangePhone()),
              ),
              ProfileMenu(
                title: 'Gender',
                value: 'male',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Date of Birth',
                value: '15/5/2003',
                onPressed: () {},
              ),

              const Divider(),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: ()=>Get.to(()=> WelcomeScreen()),
                  child: Text(
                    "Log out",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
