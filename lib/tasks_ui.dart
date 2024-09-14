import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// this page for test.....
class TasksUi extends StatefulWidget {
  const TasksUi({super.key});

  @override
  State<TasksUi> createState() => _TasksUiState();
}

class _TasksUiState extends State<TasksUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("title"),
          Text("data"),
          Text("time"),
        ],
      ),
    );
  }
}
