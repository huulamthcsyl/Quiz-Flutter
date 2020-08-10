import 'package:flutter/material.dart';
import 'package:quiz/helpers/functions.dart';
import 'package:quiz/views/home.dart';
import './views/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async {
    _isLoggedIn = await HelperFunctions.getUserLoggedInDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: (_isLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}