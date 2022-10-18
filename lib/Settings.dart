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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Text(
                      "More",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
              headers(context, 'Generals'),
              Container(
                margin: const EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: InkWell(
                  child: Text(
                    "One time payment to remove adds permanently",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              headers(context, 'About'),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    tapButton(context, 'Share with Friends', () => null),
                    tapButton(context, 'More Apps', () => null),
                    tapButton(context, 'Send us feedback', () => null),
                  ],
                ),
              ),
              headers(context, 'Follow Us'),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    tapIconButton(
                      context,
                      'WhatsApp',
                      () => null,
                      const Icon(Icons.whatsapp),
                    ),
                    tapIconButton(
                      context,
                      'FaceBook',
                      () => null,
                      const Icon(Icons.facebook),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "App version 2.0.0",
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container headers(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      color: Theme.of(context).primaryColor.withOpacity(.5),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          child: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding tapButton(BuildContext context, String title, Function() function) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: function,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
    );
  }

  Padding tapIconButton(
      BuildContext context, String title, Function() function, Icon icon) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 7,
            ),
            Text(
              title,
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ));
  }
}
