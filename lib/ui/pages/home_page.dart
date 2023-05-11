import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/login_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../theme.dart';
import '../widgets/button.dart';
import 'add_task_page.dart';
import 'package:intl/intl.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;

  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
     notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    _taskController.getTasks();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    NotifyHelper().initializeNotification;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    notifyHelper.initializeNotification();
    return  Scaffold(
      appBar: _appBar(),
      body: Container(
        height: double.infinity,
        color: context.theme.colorScheme.background,
        child: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            const SizedBox(height: 6),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      actions:  [
        TextButton(onPressed:
            (){
              notifyHelper.cancelAllNotification();
              _taskController.deleteAllTasks();
            } ,
            child: Text('Delete All !',
            style: GoogleFonts.lato(
              textStyle: TextStyle(color: Get.isDarkMode?primaryClr:darkGreyClr,
             fontSize: 18,fontWeight: FontWeight.bold
              )
            ),
            )
        ),
        IconButton(
          onPressed: (){
            ThemeServices().switchTheme();
          },
          icon:  Icon(Get.isDarkMode?Icons.light_mode:Icons.dark_mode,size: 24,
            color:Get.isDarkMode?Colors.white70:const Color.fromRGBO(48, 25, 52, 1),),
        ),
        IconButton(onPressed: (){
          Get.to(() => const logInScreen());
        },
            icon:  Icon(Icons.exit_to_app_rounded,
              size: 24,color: Get.isDarkMode?primaryClr:darkGreyClr,
            )),
      ],
      elevation: 0,
      leading: const Padding(
        padding:  EdgeInsets.only(left: 10),
        child:  CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 50,
        ),
      ),
      backgroundColor: context.theme.colorScheme.background,
    );
  }



   _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10,left: 20,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(DateFormat.yMMMEd().format(DateTime.now()),
                 style: subheadingStyle,),
              Text('Today',style: headingStyle),
            ],
          ),
         MyButton(label: '+ Add Task', onTap: () async {
           await Get.to(()=> const AddTaskPage());
           _taskController.getTasks();
         }),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6,left: 20),
      child: DatePicker(
          DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate: _selectedDate,
        dateTextStyle: GoogleFonts.lato(
          textStyle:  TextStyle(fontSize: 18,
              fontWeight: FontWeight.w600,
          color: Get.isDarkMode?primaryClr:darkGreyClr
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle:  TextStyle(fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode?primaryClr:darkGreyClr
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle:  TextStyle(fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode?primaryClr:darkGreyClr
          ),
        ),
        selectedTextColor: Colors.white,
        selectionColor: Get.isDarkMode?primaryClr:darkGreyClr,
        onDateChange: (newDate){
            setState(() {
              _selectedDate = newDate;
            });
        },
      ),
    );
  }

  Future<void> _onRefresh() async{
    await _taskController.getTasks();
  }

  _showTasks() {
    return Expanded(
      child: Obx( () {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation==Orientation.landscape?
              Axis.horizontal:Axis.vertical,
              itemBuilder: (BuildContext context, int index)
              {
                var task = _taskController.taskList[index];

                if(task.repeat=='Daily' ||
                    task.date== DateFormat.yMd().format(_selectedDate)
                || (task.repeat== 'Weekly' && _selectedDate.difference
                      (DateFormat.yMd().parse(task.date!)).inDays % 7==0)
                || (task.repeat== 'Monthly'
                   && DateFormat.yMd().parse(task.date!).day == _selectedDate.day)){
                  //var hour = task.startTime.toString().split(':')[0];
                  //var minutes = task.startTime.toString().split(':')[1];
                  //debugPrint('My time is '+ hour);
                  //debugPrint('My minutes is '+ minutes);
                  var date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat('HH:mm').format(date);

                  notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(':')[0]),
                      int.parse(myTime.toString().split(':')[1]),
                      task
                  );
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: (){
                            showBottonSheet(
                                context,
                                task
                            );
                          },
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                }else {
                  return Container();
                }
              },
              itemCount: _taskController.taskList.length,
            ),
          );
        }
      }

      ),
    );

  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape?
                Axis.horizontal:Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape?
                  const SizedBox(height: 6):
                  const SizedBox(height: 220),
                  SvgPicture.asset('images/task.svg',
                  height: 80,
                    width: 80,
                    semanticsLabel: 'Task',
                    color: Get.isDarkMode?primaryClr:darkGreyClr,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical:10 ),
                    child: Text('You do not have any tasks yet! \nAdd any tasks to make your days productive',
                    style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape?
                  const SizedBox(height: 120):
                  const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  showBottonSheet(BuildContext context, Task task){
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Get.isDarkMode?primaryClr:darkGreyClr,
            borderRadius: BorderRadius.circular(35)
          ),
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation==Orientation.landscape)?
          (task.isCompleted==1?SizeConfig.screenHeight * 0.6
              :SizeConfig.screenHeight * 0.8)
              :(task.isCompleted==1?SizeConfig.screenHeight*0.30
              :SizeConfig.screenHeight*0.39),
          child: Column(
            children: [
              Flexible(
                  child: Container(
                    height: 6,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode?primaryClr:darkGreyClr
                    ),
                  ),
              ),
              const SizedBox(height: 20),
              task.isCompleted==1?Container():
              _buildBottonSheet(
                lable: 'Task Completed',
                onTap: (){
                  notifyHelper.cancelNotification(task);
                  _taskController.markTasksCompleted(task.id!);
                  Get.back();
                },
                clr: tealClr
              ),
              _buildBottonSheet(
                  lable: 'Update Task',
                  onTap: (){
                    _taskController.updateTasks(task.id!);
                  },
                  clr: blueGray
              ),
              _buildBottonSheet(
                  lable: 'Delete Task',
                  onTap: (){
                    notifyHelper.cancelNotification(task);
                    _taskController.deleteTasks(task);
                    Get.back();
                  },
                  clr: redLClr
              ),
               Divider(color: Get.isDarkMode?primaryClr:darkGreyClr),
              _buildBottonSheet(
                  lable: 'Cancel',
                  onTap: (){
                    Get.back();
                  },
                  clr: Get.isDarkMode?darkGreyClr:primaryClr
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )
    );
  }

  _buildBottonSheet(
      {required String lable,
        required Function() onTap,
        required Color clr,
        bool isClose=false,}
      ){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose? Get.isDarkMode?
            Colors.grey[600]!:Colors.grey[300]!
                : clr
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose? Colors.transparent:clr
        ),
        child: Center(
          child: Text(lable,
            style:isClose?titleStyle:titleStyle.copyWith(color: Colors.white),),
        ),
      ),
    );
  }
}
