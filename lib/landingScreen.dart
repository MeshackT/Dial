import 'package:dial/ReusableCode.dart';
import 'package:dial/addFriends.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      if (kDebugMode) {
        print("Location permission is denied.");
      }
    } else if (statuses[Permission.photos]!.isDenied) {
      //check each permission status after.
      if (kDebugMode) {
        print("Camera permission is denied.");
      }
    } else if (statuses[Permission.phone]!.isDenied) {
      //check each permission status after.
      if (kDebugMode) {
        print("phone permission is denied.");
      }
    } else {
      if (kDebugMode) {
        print("All permissions granted");
      }
    }
  }

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Reuse reuseCode = Reuse();
    DateTime lastTap = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(lastTap);
        final exitWarning = difference >= const Duration(seconds: 2);

        lastTap = DateTime.now();
        if (exitWarning) {
          const String message = "Press again to close the app";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              duration: const Duration(seconds: 2),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    message,
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                ],
              ),
            ),
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 0.0),
              decoration: const BoxDecoration(
                //screen background color
                gradient: LinearGradient(
                    colors: [Color(0xff3D3C77), Color(0xff000000)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/nine-small.png',
                          width: 390,
                          height: 218,
                          fit: BoxFit.cover,
                        ),
                        reuseCode.speedDialHeader("Speed dial", context),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 183),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                color: const Color(0x0f09091b).withOpacity(.6),
                                height: 68,
                                width: 331,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    reuseCode.navigatorButton(
                                        Icon(
                                          Icons.emergency,
                                          size: 25.0,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                        () => null),
                                    reuseCode.navigatorButton(
                                      Icon(
                                        Icons.group,
                                        size: 25.0,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddFriends(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //title//
                  Reuse.title("Emergency", context),
                  //title ends//
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Reuse.buttonType(
                              "Ambulance",
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(.49),
                              Icons.car_repair,
                              () => Reuse.callAmbulance(),
                              context,
                            ),
                            //fighter button
                            Reuse.buttonType(
                              "Child Line",
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(.49),
                              Icons.child_care,
                              () => Reuse.callChildLine(),
                              context,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Reuse.buttonType(
                              "Police",
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(.49),
                              Icons.star,
                              () => Reuse.callPolice(),
                              context,
                            ),
                            //fighter button
                            Reuse.buttonType(
                              "Fire Fighter",
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(.49),
                              Icons.fire_truck_sharp,
                              () => Reuse.callFireFighter(),
                              context,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Reuse.buttonType(
                              "Private Ambulance",
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(.49),
                              Icons.car_rental_sharp,
                              () => Reuse.callPrivateEmergency(),
                              context,
                            ),
                            //fighter button
                            Reuse.buttonType(
                              "Net Care",
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(.49),
                              Icons.child_care,
                              () => Reuse.callNetcare(),
                              context,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
