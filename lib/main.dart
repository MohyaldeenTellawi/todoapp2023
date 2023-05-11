import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/dp/dp_helper.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/login_page.dart';
import 'ui/pages/splash_page.dart';
import 'ui/theme.dart';


void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 SharedPreferences prefs = await SharedPreferences.getInstance();
 var userName = prefs.getString('username');
 var occupation = prefs.getString('occupation');
  await DpHelper.initDp();
  await GetStorage.init();
 runApp(userName !=null && occupation !=null ? const MyApp(): const logInScreen());
 }



class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: Themes.liGht,
      darkTheme: Themes.daRk,
      themeMode: ThemeServices().theme,
      home:   const  splashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {

    return const Scaffold(
    );
  }
}
