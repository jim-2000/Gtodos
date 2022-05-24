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
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Time : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    task.date,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                    ),
                    onPressed: () {
                      taskcontroller.deleteTask(task);
                      log(taskcontroller.taskLists.length.toString());
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete),
                    label: Text("Delete Task"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(18)),
                        ),
                        builder: (BuildContext context) =>
                            _showBottomSheet(context),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text(" Add New Task"),
                  ),
                ],
              ),
              Container(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                constraints:
                    BoxConstraints.tight(Size(double.infinity, Get.height / 2)),
                decoration: BoxDecoration(
                  color: Colors.purple.shade500,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Text(
                  task.note,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  taskcontroller.deleteTask(task);
                  log(taskcontroller.taskLists.length.toString());
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 12,
                            blurStyle: BlurStyle.outer,
                            color: Colors.pink.shade200,
                            offset: Offset.zero,
                            spreadRadius: 2.0)
                      ]),
                  width: double.infinity,
                  height: 65,
                  child: const Center(
                      child: Text(
                    "Delete Task",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showBottomSheet(BuildContext context) {
    final taskcontroller = Get.put(TaskController());
    final titlecontroller = TextEditingController();
    final descriptioncontroller = TextEditingController();
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: Colors.purple.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Center(
                child: Text(
                  "Add New TASK",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Container(
                  height: 6,
                  width: 46,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: titlecontroller,
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: "Note title.."),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: descriptioncontroller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    hintText: "Note Description..",
                  ),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async {
                  await taskcontroller.addTask(
                    task: Task(
                      title: titlecontroller.text,
                      note: descriptioncontroller.text,
                      isCompleted: 0,
                      date: DateTime.now().toIso8601String(),
                    ),
                  );
                  log("submit");
                  taskcontroller.getallTask();
                  log(taskcontroller.taskLists.length.toString());
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade600,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text(
                    "SUBMIT YOUR NOTE",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
