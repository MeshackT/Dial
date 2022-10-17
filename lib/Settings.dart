import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff3D3C77),
        title: Text(
          'Settings',
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 14),
        ),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/addFriends', (route) => false);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 0.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff3D3C77), Color(0xff000000)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              Text(
                "About",
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  child: Text(
                    "Share with Frinds",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Text(
                "App Version: 2.0.0",
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
