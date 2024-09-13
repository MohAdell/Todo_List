import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:app2/view/widget/default_from_filed.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'constant.dart';
import 'data/local_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Notch Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// widget list
    final List<Widget> bottomBarPages = [
      Page1(
        controller: (_controller),
      ),
      Page2(),
      const Page3(),
      const Page4(),
      const Page5(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,

              // notchShader: const SweepGradient(
              //   startAngle: 0,
              //   endAngle: pi / 2,
              //   colors: [Colors.red, Colors.green, Colors.orange],
              //   tileMode: TileMode.mirror,
              // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
              notchColor: Colors.black87,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,

              itemLabelStyle: const TextStyle(fontSize: 10),

              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.task,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.task,
                    color: Colors.white,
                  ),
                  itemLabel: 'Tasks',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.add, color: Colors.black),
                  activeItem: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  itemLabel: 'Add',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.add_task_outlined,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.add_task_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: 'Done',
                ),
              ],
              onTap: (index) {
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}

/// add controller to check weather index through change or not. in page 1
class Page1 extends StatefulWidget {
  final NotchBottomBarController? controller;

  const Page1({Key? key, this.controller}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      width: 200,
      height: 300,
      color: Colors.white70,
      child: Center(
        /// adding GestureDetector
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            widget.controller?.jumpTo(2);
          },
          child:
              // const Text('Tasks'),
              Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

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

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Center(child: Text('Page 4')));
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 5')));
  }
}
