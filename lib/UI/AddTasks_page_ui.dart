import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../constant.dart';
import '../view/widget/default_from_filed.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late Database database;
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Page2 screens = Page2();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((Value) {
                  timerController.text = Value!.format(context).toString();
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
                dateController.text = DateFormat.yMMMMd().format(value!);
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // LocalDataBase().insertDataBase(
              //     title: tasksController.text,
              //     time: timerController.text,
              //     date: dateController.text);
              // database.transaction;
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 60,
            ),
            style: ButtonStyle(
              // minimumSize: MaterialStateProperty.all(Size.fromHeight(20)),
              /// <--- add this
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.green;
                } else {
                  return Colors.white10;
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
