import 'package:dial/ReusableCode.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
          content: Text(
            'Tap back again to leave',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
        child: SafeArea(
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
                  Stack(
                    children: [
                      Image.asset(
                        'images/nine-small.png',
                        width: 390,
                        height: 218,
                        fit: BoxFit.cover,
                      ),
                      Reuse.speedDialHeader("Speed dial", context),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 183),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              color: const Color(0x0f09091b).withOpacity(.6),
                              height: 68,
                              width: 331,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Reuse.navigatorButton(
                                      Icon(
                                        Icons.emergency,
                                        size: 25.0,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      () => null),
                                  Reuse.navigatorButton(
                                    Icon(
                                      Icons.group,
                                      size: 25.0,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                    () => Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/addFriends',
                                        (route) => false),
                                  ),
                                  Reuse.navigatorButton(
                                    Icon(
                                      Icons.settings,
                                      size: 25.0,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                    () => Navigator.pushNamedAndRemoveUntil(
                                        context, '/settings', (route) => false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
