import 'package:dial/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Reuse {
  //button cards emergency
  static ClipRRect buttonType(String title, Color color, icon,
      Function() onPress, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: color,
        width: 100,
        height: 100,
        child: ElevatedButton(
          onPressed: onPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 11),
              ),
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).primaryColorLight,
              )
            ],
          ),
        ),
      ),
    );
  }

  //navigation header page name Speed dial
  static Center title(String header, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          header,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
    );
  }

  //speed dial Top header
  static Center speedDialHeader(String headerText, BuildContext context) {
    return Center(
      child: Text(
        headerText,
        style: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          letterSpacing: 1,
        ),
      ),
    );
  }

  /*
  * Call functions for emergency purposes
  * navigation functions
  */
  static IconButton navigatorButton(Icon icon, Function() onPress) {
    return IconButton(
      onPressed: onPress,
      icon: icon,
    );
  }

  //call function for departments
  static Future<void> callAmbulance() async {
    const String number = '08177';
    await FlutterPhoneDirectCaller.callNumber(number).whenComplete(
      () => const MyHomePage(),
    );
  }

  static Future<void> callPolice() async {
    const String number = '10111';
    await FlutterPhoneDirectCaller.callNumber(number).whenComplete(
      () => const MyHomePage(),
    );
  }

  static Future<void> callChildLine() async {
    const String number = '116';
    await FlutterPhoneDirectCaller.callNumber(number).whenComplete(
      () => const MyHomePage(),
    );
  }

  static Future<void> callNetcare() async {
    const String number = '0829111';
    await FlutterPhoneDirectCaller.callNumber(number).whenComplete(
      () => const MyHomePage(),
    );
  }

  static Future<void> callPrivateEmergency() async {
    const String number = '0873652087';
    await FlutterPhoneDirectCaller.callNumber(number).whenComplete(
      () => const MyHomePage(),
    );
  }

  static Future<void> callFireFighter() async {
    const String number = '0800055555';
    await FlutterPhoneDirectCaller.callNumber(number).whenComplete(
      () => const MyHomePage(),
    );
  }

  //Share details
  static display(BuildContext context, String nameTemporary,
      String phoneTemporary, String message) async {
    return await Share.share('$nameTemporary\n$phoneTemporary').then(
      (value) => Fluttertoast.showToast(
        msg: "Sharing contacts",
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryColorLight,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> callSnack(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            "Number Copied",
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          )),
    );
  }

  //whatsapp call
  static Future<void> openWhatsApp(BuildContext context,
      {@required phoneNumber, @required message}) async {
    //var url = Uri.parse("whatsapp://send?phone=$phoneNumber&text=$message");

    var whatsAppURlAndroid =
        Uri.parse("whatsApp://send?phone=$phoneNumber}&text=$message");
/*    var whatsAppURLIos =
        "https://wa.me/$phoneNumber?text=${Uri.parse("hello")}";*/

    /*search for checking platforms later*/
    await canLaunchUrl(whatsAppURlAndroid)
        ? launchUrl(whatsAppURlAndroid)
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              content: Text(
                "Can't open whatsApp",
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            ),
          );
  }
}
