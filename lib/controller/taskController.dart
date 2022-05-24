import 'package:get/get.dart';
import 'package:travella/model/taskModel.dart';

class TaskController extends GetxController {
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  addTask(Task task) {
    _tasks.add(task);
    update();
  }
  //

  deleteTask(int id) {
    _tasks.removeWhere((element) => element.id == id);
    update();
  }
}
