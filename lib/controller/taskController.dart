import 'package:get/get.dart';
import 'package:travella/db/Db.dart';
import 'package:travella/model/taskModel.dart';

class TaskController extends GetxController {
  //
  @override
  void onReady() {
    getallTask();
    // TODO: implement onReady
    super.onReady();
  }

  //
  final taskLists = <Task>[].obs;

//
  void getallTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    // tasks.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
    taskLists.assignAll(tasks.map<Task>((t) => Task.fromJson(t)).toList());
  }

//
  addTask({required Task task}) async {
    return await DBHelper.insert(task);
  }

  //

  deleteTask(Task task) async {
    await DBHelper.delete(task);
    getallTask();
  }

  // mark true task
  void markTaskComplete(int id) async {
    await DBHelper.update(id);
    getallTask();
  }

  //
  void unMarkTaskComplete(int id) async {
    await DBHelper.updateAgain(id);
    getallTask();
  }

  // trying to toggleing
  void toggleing(int id, bool b) async {
    b == true ? await DBHelper.toggle(id, 1) : await DBHelper.toggle(id, 0);
    getallTask();
  }
}
