import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:police_app/Compo/user_controller.dart';
// import 'package:police_app/Pages/Home/BroadcastPage.dart';
import 'package:police_app/Profile/EditProfile.dart';
import 'package:video_player/video_player.dart';
// import 'package:police_app/Pages/Home/Callpage.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key, this.isNetworkImage = false});
  final bool isNetworkImage;

  @override
  State<Notifications> createState() => _ApplicaState();
}

class _ApplicaState extends State<Notifications> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfile()),
                      );
                    },
                      child: Container(

                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment(1, 0.4),
                          //   colors: <Color>[
                          //     Color(0xffffb56b),
                          //     Color(0xfff39060),
                          //     Color(0xfff39060),
                          //     Color(0xffe16b5c),
                          //     Color(0xffe16b5c),
                          //     Color(0xffe16b5c),
                          //     Color(0xfff39060),
                          //     Color(0xffffb56b),
                          //   ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          //   tileMode: TileMode.mirror,
                          // ),
                          color: Color(0xff4A8CB0),
                          borderRadius: BorderRadius.circular(20), // Border radius
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final networkImage = controller.user.value.profilePicture;
                              final image = networkImage.isNotEmpty
                                  ? networkImage
                                  : 'assets/images/profile.png';
                              return Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Center(
                                    child: networkImage.isNotEmpty
                                        ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: image,
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    )
                                        : Image(
                                      fit: BoxFit.cover,
                                      image: widget.isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                  controller.user.value.fullName,
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,color: Colors.white),
                                )),
                                Obx(() => Text(
                                  controller.user.value.email,
                                  style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
