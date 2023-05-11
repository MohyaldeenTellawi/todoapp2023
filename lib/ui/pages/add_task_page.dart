import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
   DateTime _selectedDate = DateTime.now();
   String _startTime =
      DateFormat('hh:mm a').format(DateTime.now()).toString();
   String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 5)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
   int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        height: double.infinity,
        color: context.theme.colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Text('Add Task', style: headingStyle),
                const SizedBox(height: 4.5),
                InputField(
                  controller: _titleController,
                  title: 'Title',
                  hint: 'Enter Title',
                ),
                InputField(
                  controller: _noteController,
                  title: 'Note',
                  hint: 'Enter Note',
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () => _getDateFromUser(),
                    icon: const Icon(Icons.calendar_today_outlined,
                        color: Colors.grey),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () => _getTimeFromUser(isStartTime: true),
                          icon: const Icon(Icons.access_time_outlined,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () => _getTimeFromUser(isStartTime: false),
                          icon: const Icon(Icons.access_time_outlined,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: 'Remind',
                  hint: '$_selectedRemind minutes early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        borderRadius: BorderRadius.circular(20),
                        dropdownColor: Colors.white,
                        items: remindList
                            .map<DropdownMenuItem<String>>(
                                (int val) => DropdownMenuItem<String>(
                                    value: val.toString(),
                                    child: Text(
                                      '$val',
                                      style:  const TextStyle(color: darkGreyClr),
                                    )))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRemind = int.parse(newValue!);
                          });
                        },
                        icon:  const Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0),
                        style: subTitleStyle,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                InputField(
                  title: 'Repeat',
                  hint: _selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                                (String val) => DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: const TextStyle(color: darkGreyClr),
                                    )))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRepeat = newValue!;
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0),
                        style: subTitleStyle,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorpalette(),
                    MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateDate();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 50,
        ),
         SizedBox(width: 20),
      ],
      elevation: 0,
      leading: IconButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios,size: 24, color:Colors.blueGrey),
      ),
      backgroundColor: context.theme.colorScheme.background,
    );
  }

   _validateDate(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskstoDP();
      Get.back();
    }else if
      (_titleController.text.isEmpty || _noteController.text.isEmpty){
        Get.snackbar('Required',
            'All fields are Required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.isDarkMode?primaryClr:darkGreyClr,
          colorText: Get.isDarkMode?darkGreyClr:primaryClr,
          icon:  Icon(Icons.warning_amber_rounded,
            color:Get.isDarkMode?darkGreyClr:primaryClr),
        );
      }
    else{
      print('Something Bad Happened');
    }
   }

   _addTaskstoDP() async {
    int id =  await _taskController.addTask(
      task : Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
          endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat
      ),
    );
    print('$id');
  }

  Column _colorpalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [Text('Color', style:titleStyle),
      const SizedBox(height: 12),
      Wrap(
        children: List<Widget>.generate(5, (index) =>
            GestureDetector(
              onTap: (){
                setState(() {
                  _selectedColor = index;
                });
              },
              child:  Padding(
                padding: const EdgeInsets.only(right: 12),
                child:  CircleAvatar(
                  radius: 13,
                  backgroundColor: index==0?pinkCrl:
                  index==1?orangeClr:index==2?tealClr:
                      index==3?redLClr: bluishClr,
                  child: _selectedColor==index? const Icon(Icons.done,size: 20,color: Colors.white):null,
                ),
              ),
            ),
        )
      ),
      ],
    );
  }

  _getDateFromUser() async {
   DateTime? _pickedDate =  await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),);

   if(_pickedDate!=null){
     setState(() {
       _selectedDate = _pickedDate;
     });
   }else{
     print('The date was not selected');
   }
  }


  _getTimeFromUser({required bool isStartTime})async {

    TimeOfDay? _pickedTime =  await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: isStartTime?
          TimeOfDay.fromDateTime(DateTime.now())
          :TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 5))),
     );
 // ignore: use_build_context_synchronously
 String formattedTime = _pickedTime!.format(context) ;
    if(isStartTime){setState(() {
      _startTime = formattedTime;
    });}
     else if(!isStartTime){setState(() {
       _endTime = formattedTime;
     });}
       else print('The time was not selected');
  }
}
