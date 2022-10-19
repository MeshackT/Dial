import 'package:dial/feedback%20class/feedbackclass.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class EmailTemplate extends StatelessWidget {
  const EmailTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController subject = TextEditingController();
    final TextEditingController message = TextEditingController();

    clearText() {
      name.clear();
      email.clear();
      subject.clear();
      message.clear();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff3D3C77),
        title: Text(
          'Send Your Feedback',
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 14),
        ),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/settings', (route) => false);
          },
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
          content: Text(
            'Tap back again to leave the application',
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
                gradient: LinearGradient(
                    colors: [Color(0xff3D3C77), Color(0xff000000)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  inputHere(context, name, "Name", "Enter your name...", 1),
                  spaceInBetween(),
                  inputHere(context, email, "Email", "example@gmail.com", 1),
                  spaceInBetween(),
                  inputHere(context, subject, "Subject", "Subject line...", 1),
                  spaceInBetween(),
                  inputHere(context, message, "Message",
                      "FeedBack message here...", 5),
                  spaceInBetween(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          //show this message when you click send
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              content: Text(
                                "Sending email...",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                            ),
                          );
                          //send your email feedback
                          SendEmail.sendEmail(
                            name: name.text,
                            message: message.text,
                            subject: subject.text,
                            email: email.text,
                          ).then(
                            (value) =>
                                clearText(), //clear textInputs after sending
                          );
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /////////////////////////////////
  Padding inputHere(
    BuildContext context,
    TextEditingController inputTitle,
    String title,
    String hintMessage,
    int textArea,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        cursorWidth: 1,
        autofocus: false,
        autocorrect: true,
        showCursor: true,
        controller: inputTitle,
        maxLines: textArea,
        cursorColor: Theme.of(context).primaryColorLight,
        style: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hintMessage,
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(.50),
          filled: true,
          label: Text(
            title,
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: (val) {
          if (inputTitle.text.isNotEmpty) {
            val = inputTitle.text;
          } else {
            'Enter detail';
          }
          return null;
        },
      ),
    );
  }

  SizedBox spaceInBetween() {
    return const SizedBox(
      height: 8.0,
    );
  }
}
