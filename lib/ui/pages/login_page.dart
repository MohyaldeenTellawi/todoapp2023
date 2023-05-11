
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';
import '../../models/account.dart';
import '../../services/notification_services.dart';
import '../../services/preferences_services.dart';
import '../../services/theme_services.dart';
import 'about_page.dart';
class logInScreen extends StatefulWidget {
  const logInScreen({Key? key}) : super(key: key);

  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  late NotifyHelper notifyHelper;
  final _userNameController = TextEditingController();
  final _occupationController = TextEditingController();
  bool isRegister = false;




 @override
  void initState() {
   notifyHelper = NotifyHelper();
   notifyHelper.requestIOSPermissions();
   notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            ThemeServices().switchTheme();
          },
          icon:  Icon(Get.isDarkMode?Icons.light_mode:Icons.dark_mode,size: 24,
            color:Get.isDarkMode?Colors.white70:const Color.fromRGBO(48, 25, 52, 1),),
        ),
        backgroundColor: context.theme.colorScheme.background,
      ),
      body:  Container(
          height: double.infinity,
          color: context.theme.colorScheme.background,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hello Again!',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Get.isDarkMode?primaryClr:darkGreyClr,
                          fontSize: 30,fontWeight: FontWeight.w700
                        ),
                      ),
                      ),
                      const SizedBox(width: 3),
                      Image.asset('images/helllo.png',
                        filterQuality:FilterQuality.high ,
                        fit: BoxFit.fill,
                        width: 60,height: 60,
                        colorBlendMode: BlendMode.overlay,
                      ),
                    ],
                  ),
                  Image.asset('images/icon.png',width: 200,height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('"Don\'t worry about the many tasks, ToDo is here"',
                        style: GoogleFonts.lato(
                          textStyle:  TextStyle(
                            color: Get.isDarkMode?primaryClr:darkGreyClr,
                            fontSize: 15,fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Image.asset('images/signup.png',
                        width: 60,height: 60,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            margin: const EdgeInsets.only(left: 15,right: 15),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode?primaryClr:darkGreyClr,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                color:
                                Get.isDarkMode?darkGreyClr:primaryClr
                            ),
                            controller: _userNameController,
                            decoration: InputDecoration(
                              hintText: 'UserName',
                                hintStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Get.isDarkMode?darkGreyClr:primaryClr
                                  ),
                                ),
                                icon: Icon(Icons.person,
                                  color: Get.isDarkMode?darkGreyClr:primaryClr,
                                ),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          margin: const EdgeInsets.only(left: 15,right: 15),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode?primaryClr:darkGreyClr,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                color:
                                Get.isDarkMode?darkGreyClr:primaryClr
                            ),
                            controller: _occupationController,
                            decoration: InputDecoration(
                                hintText: 'Occupation',
                                hintStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Get.isDarkMode?darkGreyClr:primaryClr
                                  ),
                                ),
                                icon: Icon(Icons.work_outline,
                                  color: Get.isDarkMode?darkGreyClr:primaryClr,
                                ),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: ()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('username', _userNameController.text);
                    prefs.setString('occupation', _occupationController.text);
                    print(_userNameController.text);
                    print(_occupationController.text);
                       Get.to(() => const HomePage());
                    },
                      child: Text('Let\'s go!',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 20,
                           color:Get.isDarkMode?primaryClr:darkGreyClr),),
                      ),
                  ),
                ],
              ),
            ),
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.isDarkMode?primaryClr:darkGreyClr,
        onPressed: (){
          Get.to(const AboutPage());
        },
        child:  Icon(Icons.info_outlined,size: 50,
        color: Get.isDarkMode?darkGreyClr:primaryClr,
        ),
      ),
    );
  }
}

