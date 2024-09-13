import 'package:app2/view/tasks_page.dart';
import 'package:app2/view/widget/default_from_filed.dart';
import 'package:app2/view/widget/default_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../constant.dart';
import '../data/local_data.dart';
import 'delete_page.dart';
import 'package:app2/view/widget/default_from_filed.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Database database;
  int currentIndex = 0;
  @override
  void initState() {
    // crateDataBase();
    super.initState();
  }

  List<Widget> screens = const [
    TasksPage(),
    DeletePage(),
  ];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   title: DefaultText(
      //     date: 'Todo List',
      //   ),
      // ),
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        onPressed: () {
          scaffoldKey.currentState?.showBottomSheet((context) {
            return Container(
              padding: EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                //Old text filed
                // children: [
                //   TextField(
                //     decoration: InputDecoration(
                //         hintText: "Task",
                //         suffixIcon: Icon(Icons.task),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20))),
                //   ),
                //   const SizedBox(
                //     height: 20,
                //   ),
                //   TextField(
                //     decoration: InputDecoration(
                //         hintText: "Date",
                //         suffixIcon: Icon(Icons.calendar_month),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20))),
                //   ),
                //   const SizedBox(
                //     height: 20,
                //   ),
                //   TextField(
                //     decoration: InputDecoration(
                //         hintText: "Time",
                //         suffixIcon: Icon(Icons.timer),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20))),
                //   ),
                //   const SizedBox(
                //     height: 20,
                //   ),
                //   TextField(
                //     decoration: InputDecoration(
                //         hintText: "Description",
                //         suffixIcon: Icon(Icons.description),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20))),
                //   ),
                // ],

                // New text filed
                children: [
                  DefaultFromFiled(
                    controller: tasksController,
                    valid: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter valid";
                      }
                      return null;
                    },
                    Keyboard: TextInputType.text,
                    hint: "Tasks",
                    suffixIcon: Icon(Icons.task),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFromFiled(
                      controller: timerController,
                      valid: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter valid";
                        }
                        return null;
                      },
                      Keyboard: TextInputType.datetime,
                      hint: "Time",
                      suffixIcon: Icon(Icons.timer),
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((Value) {
                          timerController.text =
                              Value!.format(context).toString();
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFromFiled(
                    controller: dateController,
                    valid: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter valid";
                      }
                      return null;
                    },
                    Keyboard: TextInputType.text,
                    hint: "Date",
                    suffixIcon: Icon(Icons.date_range),
                    onTap: () async {
                      await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030))
                          .then((value) {
                        dateController.text =
                            DateFormat.yMMMMd().format(value!);
                      });
                    },
                  ),
                ],
              ),
            );
          });
        },
        disabledElevation: 0,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // setState(() {
          //   currentIndex = index;
          //   LocalDataBase().addDataLocally(
          //       title: tasksController.text,
          //       time: timerController.text,
          //       date: dateController.text);
          // });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete')
        ],
      ),
    );
  }
}
