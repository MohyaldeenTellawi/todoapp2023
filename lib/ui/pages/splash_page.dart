import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/pages/login_page.dart';
import 'package:todo/ui/theme.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  var userName = '';
  var occupation = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Get.isDarkMode?darkGreyClr:primaryClr,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: userName != null && occupation != null?const HomePage():const logInScreen(),
        splash: 'images/icon.png',
        duration: 1600,
        splashIconSize: 350,
      ),
    );
  }

  Future<void> get () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString('username');
    var occupation = prefs.getString('occupation');
  }
}
