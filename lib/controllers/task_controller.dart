import 'package:get/get.dart';
import 'package:todo/dp/dp_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController{

  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}){
  return DpHelper.insert(task);
  }
  Future<void> getTasks() async {
  final tasks = await DpHelper.query();
  taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTasks(Task task) async {
    await DpHelper.delete(task);
    getTasks();

  }

  void deleteAllTasks() async {
    await DpHelper.deleteAll();
    getTasks();

  }

  void updateTasks(int id) async {
    await DpHelper.update(id);
    getTasks();
  }

  void markTasksCompleted(int id) async {
    await DpHelper.update(id);
   getTasks();
  }
}