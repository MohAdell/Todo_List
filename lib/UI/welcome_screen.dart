import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TodoAppUi.dart';
import '../constant.dart';
import '../data/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final SharedPreferencesClass SP = SharedPreferencesClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Welcome to TODO List App"),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: namedController,
              decoration: InputDecoration(
                label: Text('Enter Your Name'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String userNameTasks = namedController.text;
                  SharedPreferences SP = await SharedPreferences.getInstance();
                  if (userNameTasks.isEmpty) {
                    await SP.setString("username", userNameTasks);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                  print("done save name");
                },
                child: Text('Go'))
          ],
        ),
      ),
    );
  }
}
