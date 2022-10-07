import 'package:flutter/material.dart';

import 'landingScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speed dial',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColorDark: Colors.deepPurple,
        primaryColorLight: Colors.white,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Speed Dial'),
    );
  }
}
