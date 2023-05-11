import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';




class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);


  final String payload;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  late NotifyHelper notifyHelper;
  String _payload = '';
  String userName = '';

  final _userNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    NotifyHelper().initializeNotification;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions:  [
          const CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 50,
          ),
          const SizedBox(width: 20),
          IconButton(
              onPressed: (){
                ThemeServices().switchTheme();
              },
              icon: Icon(Get.isDarkMode?Icons.light_mode:Icons.dark_mode,size: 24,
                color:Get.isDarkMode?primaryClr:darkGreyClr),
          ),
        ],
        elevation: 0,
        leading: IconButton(
          onPressed:(){
            Get.to(const HomePage());
          },
          icon:  Icon(Icons.arrow_back_ios,size: 24,color:
          Get.isDarkMode?primaryClr:darkGreyClr
          ),
        ),
          backgroundColor: context.theme.colorScheme.background,
        title: Text(_payload.toString().split('|')[0],
        style:  TextStyle(
          color: Get.isDarkMode?primaryClr:darkGreyClr,
            fontSize: 20
        ),
        ),
      ),
      body: Container(
        color: context.theme.colorScheme.background,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Text('Hello $userName',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode?primaryClr:darkGreyClr
                  ),
                  ),
                  const SizedBox(height: 10),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('You have a new Reminder!',
                  style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 21,
                        color: Get.isDarkMode?primaryClr:darkGreyClr
                  ),
                  ),
                       Image.asset('images/newremind.webp',
                       width: 75,height: 75,
                         color: Get.isDarkMode?primaryClr:darkGreyClr,
                       )
                     ],
                   ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(child:
              Container(
                padding:const EdgeInsets.symmetric(
                  horizontal: 30,vertical: 15,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Get.isDarkMode?primaryClr:darkGreyClr
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children:  [
                         Icon(Icons.title,
                        size: 35,
                          color: Get.isDarkMode?darkGreyClr:primaryClr,
                        ),
                         const SizedBox(width: 20),
                        Text('Title',
                        style: TextStyle(
                          fontSize: 30,
                            color: Get.isDarkMode?darkGreyClr:primaryClr
                        ),),
                      ],),
                      const SizedBox(height: 7),
                      Text(_payload.toString().split('|')[0],
                      style:  TextStyle(
                        color: Get.isDarkMode?darkGreyClr:primaryClr,
                        fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 20),
                      Row(children: [  Icon(Icons.description,
                        size: 35,
                        color: Get.isDarkMode?darkGreyClr:primaryClr,
                      ),
                        const SizedBox(width: 20),
                        Text('description',
                          style: TextStyle(
                              fontSize: 30,
                              color: Get.isDarkMode?darkGreyClr:primaryClr
                          ),),],),
                      const SizedBox(height: 7),
                      Text(_payload.toString().split('|')[1],
                        style:  TextStyle(
                            color: Get.isDarkMode?darkGreyClr:primaryClr,fontSize: 20,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 20),
                      Row(children:  [
                         Icon(Icons.calendar_today_rounded,
                          size: 35,
                          color: Get.isDarkMode?darkGreyClr:primaryClr,
                        ),
                        const SizedBox(width: 20),
                        Text('Date',
                          style: TextStyle(
                              fontSize: 30,
                              color: Get.isDarkMode?darkGreyClr:primaryClr
                          ),),

                      ],),
                      const SizedBox(height: 15),
                      Text(_payload.toString().split('|')[2],
                        style:  TextStyle(
                            color: Get.isDarkMode?darkGreyClr:primaryClr,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ),),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

}
