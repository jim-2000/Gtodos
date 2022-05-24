import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travella/controller/taskController.dart';
import 'package:travella/model/taskModel.dart';
import 'package:travella/pages/TaskDetailsPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.put(TaskController());
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildAddTask(),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: Get.height / 2,
                  child: Obx(() {
                    return showTask(taskcontroller);
                  }))
            ],
          ),
        ));
  }

  ListView showTask(TaskController taskcontroller) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: taskcontroller.taskLists.length,
        itemBuilder: (c, i) {
          final task = taskcontroller.taskLists[i];
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => TaskDetailse(task: task)));
            },
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                title: Text(taskcontroller.taskLists[i].title.toString()),
                subtitle: Text(taskcontroller.taskLists[i].date),
                leading: Checkbox(
                    value: taskcontroller.taskLists[i].isCompleted == 0
                        ? false
                        : true,
                    onChanged: (e) {
                      log(e.toString());
                    }),
              ),
            ),
          );
        });
  }

  Widget buildAddTask() {
    final taskcontroller = Get.put(TaskController());
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TOTAL TASK  ${taskcontroller.taskLists.length}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                "COMPLETED TASK ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
                builder: (BuildContext context) => _showBottomSheet(context),
              )
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "add New TAsk",
              ),
            ),
          ),
        ],
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




//
