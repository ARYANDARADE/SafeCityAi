import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:police_app/Compo/user_controller.dart';
import 'package:police_app/Pages/Home/HomeContainer.dart';
import 'package:police_app/Pages/TopnavPages/article.dart';
import 'package:police_app/Pages/TopnavPages/notification.dart';

// import 'package:police_app/Pages/Home/BroadcastPage.dart';
import 'package:police_app/Profile/EditProfile.dart';
import 'package:video_player/video_player.dart';

import '../TopnavPages/news.dart';
// import 'package:police_app/Pages/Home/Callpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.isNetworkImage = false});
  final bool isNetworkImage;
  // final myController = TextEditingController();
  // bool _validateError = false;
  // final PermissionHandler _permissionHandler = Permissi


  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
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
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    News(),
    Articles(),
    Notifications(),
  ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xff1F1F21),
        appBar:  AppBar(
          backgroundColor:Color(0xff1F1F21),
          title: Row(
            children: [
              Text(
                'SafeCity',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,fontStyle:FontStyle.italic,
                  color: Colors.white,),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.home,color: Color(0xff4A8CB0),size: 27,), text: 'News',),
              Tab(icon: Icon(Icons.favorite,color:Color(0xff4A8CB0),size: 27,), text: 'Article'),
              Tab(icon: Icon(Icons.person,color: Color(0xff4A8CB0),size: 27,), text: 'Notification'),
            ],
          ),
        ),
        body:TabBarView(
          children: _tabs,
        ),

      ),
    );
  }
  // Future<void> onJoin() async{
  //   setState(() {
  //     myController.text.isEmpty
  //         ? _validateError = true
  //         : _validateError = false;
  //   });
  //   await _permissionHandler.requestPermissions([PermissionGroup.camera, PermissionGroup.microphone]);
  //
  //   Navigator.push(context,
  //       MaterialPageRoute(
  //         builder: (context)=> CallPage(channelName: myController.text, key: null,),)
  //   );
  // }
}
