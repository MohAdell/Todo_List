import 'dart:io';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:app2/UI/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../data/local_data.dart';
import 'TodoAppUi.dart';
import 'avatar.dart';

class Page1 extends StatefulWidget {
  final NotchBottomBarController? controller;

  const Page1({Key? key, this.controller}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late final controller = SlidableController(this as TickerProvider);
  String? userNameTasks = '';
  Future get() async {
    SharedPreferences SP = await SharedPreferences.getInstance();

    setState(() {
      userNameTasks = SP.getString("username");
    });
  }

  List<Map> tasksList = [];
  @override
  void initState() {
    super.initState();
    _initializeDataBaseAndGetTasks();
  }

  Future<void> _initializeDataBaseAndGetTasks() async {
    await crateDataBase();
    await getTask();
    await get();
  }

  Future<void> getTask() async {
    tasksList = await getDataBase(Database as Database);
    setState(() {});
  }

  Future<void> deletTask() async {
    await updateDatabase();
    await deleteDataBase();
    await getTask();
    setState(() {});
  }

  logout() async {
    await deletAllTasks();
    // await SP.clearName();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
          title: Text("Tasks Page"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: avatarImage == null
                        ? const AssetImage("assets/image/anonymous_Avatar.jpg")
                        : FileImage(avatarImage!),
                    radius: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Avatar(ImageSource.gallery);
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: ((builder) => bottomCamera()));
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Welcome $userNameTasks",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        fontFamily: Bidi.PDF),
                  )
                ],
              ),
            ),
            Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {}),

                // All actions are defined in the children parameter.
                children: const [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (_) => controller.openEndActionPane(),
                    backgroundColor: const Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.task_alt_sharp,
                    label: 'Done',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: const ListTile(
                title: Text("this text for test",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
