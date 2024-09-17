import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:app2/UI/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TodoAppUi.dart';
import '../data/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferencesClass SP = SharedPreferencesClass();
  void check() async {
    String? name = await SP.getName();
    if (name != null && name.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      gifPath: 'assets/image/notebook.gif',
      gifWidth: 269,
      gifHeight: 474,
      backgroundColor: Color(0xFFFFFFFF),
      setStateTimer: Duration(milliseconds: 100),
      nextScreen: const WelcomeScreen(),
      duration: const Duration(milliseconds: 3515),
      onInit: () async {
        debugPrint("onInit");
      },
      onEnd: () async {
        debugPrint("onEnd 1");
      },
    );
  }
}
