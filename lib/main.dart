import 'package:dial/addFriends.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'landingScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*get permission*/
  Future<void> getPermission() async {
    await Permission.phone.request();
    await Permission.photos.request();
    await Permission.contacts.request();

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.contacts,
      Permission.photos,
      Permission.phone,

      //add more permission to request here.
    ].request();

    if (statuses[Permission.contacts]!.isDenied) {
      //check each permission status after.
      //showToast("Permission Denied");
      print("Permission Denied");
    } else if (statuses[Permission.photos]!.isDenied) {
      //check each permission status after.
      //showToast("Permission Denied");
      print("Permission Denied");
    } else if (statuses[Permission.phone]!.isDenied) {
      //check each permission status after.
      //showToast("Permission Denied");
      print("Permission Denied");
    } else {
      //showToast("Permission Granted");
      print("Permission Granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speed Dial',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColorDark: Colors.deepPurple,
        primaryColorLight: Colors.white,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/addFriends': (context) => const AddFriends(),
      },
    );
  }

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  /*void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }*/
}
