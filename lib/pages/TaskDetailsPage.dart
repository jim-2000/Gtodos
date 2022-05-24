import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travella/controller/taskController.dart';
import 'package:travella/model/taskModel.dart';

class TaskDetailse extends StatelessWidget {
  final Task task;
  const TaskDetailse({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.purple.shade100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Time : ${task.date}"),
                Checkbox(
                    value: task.isCompleted == 1 ? true : false,
                    onChanged: (e) {})
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    taskcontroller.deleteTask(task);
                    log(taskcontroller.taskLists.length.toString());
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Delete Task"),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text(" Add New Task"),
                ),
              ],
            ),
            Text(task.title),
            Text(task.note),
          ],
        ),
      ),
    );
  }
}
