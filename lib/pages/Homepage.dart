import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travella/controller/taskController.dart';
import 'package:travella/model/taskModel.dart';

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
          child: Column(
            children: [
              buildAddTask(),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                  height: Get.height / 2,
                  child: Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: taskcontroller.taskLists.length,
                        itemBuilder: (c, i) {
                          return Card(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              title: Text(
                                  taskcontroller.taskLists[i].title.toString()),
                              leading: Text(
                                  taskcontroller.taskLists[i].id.toString()),
                            ),
                          );
                        });
                  }))
            ],
          ),
        ));
  }

  Widget buildAddTask() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "TOTAL TASK ",
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
                      isCompleted: 1,
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
