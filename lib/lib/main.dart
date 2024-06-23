import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:police_app/models/data_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:police_app/AuthenticationRepository.dart';
import 'package:police_app/Compo/NetwokManager.dart';
import 'package:police_app/Compo/general_binding.dart';
import 'package:police_app/LogSign/Welcome.dart';
import 'package:police_app/OnBoardingScreen/OnBoardingScreen.dart';
import 'firebase_options.dart';


Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding')??false;
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).
  then((FirebaseApp value)=> Get.put(AuthenticationRepository()),);
  await GetStorage.init();
  Get.put(AuthenticationRepository());

  runApp(MultiProvider( // Wrap your app with MultiProvider
    providers: [
      ChangeNotifierProvider(create: (_) => UserDataStore()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(onboarding: onboarding),
    ),
  ));
  Get.put(NetworkManager());
}

class SplashScreen extends StatelessWidget {
  final bool onboarding;

  const SplashScreen({Key? key, required this.onboarding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/Animation - 1704652756931.json',
              width: 400,
              height: 400,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              "AROGYA",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key,this.onboarding = false});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      title: 'My Flutter App',
      home: onboarding ? WelcomeScreen() : OnboardingScreen(),
    );
  }
}
