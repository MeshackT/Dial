import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ReusableCode.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({Key? key}) : super(key: key);

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  //store contacts
  List<Contact> contacts = [];
  List<Contact> contactFiltered = [];
  //input field
  final TextEditingController search = TextEditingController();
  Logger log = Logger(printer: PrettyPrinter(colors: true));
  //initially we don't know which platform is used
  String platformVersion = 'Unknown';

  // in order to change the search while typing, we need to bind the controller to listener
  @override
  void initState() {
    super.initState();
    getAllContacts();
    search.addListener(() {
      filterContext();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  /*Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
    });
  }*/

  filterContext() async {
    // A list to store contacts
    List<Contact> contact = [];
    //adding contacts from phone and add them to new list
    contact.addAll(contacts);

    //check the search text if it is empty or not
    if (search.text.isNotEmpty) {
      //this removes all that is not in the search
      contact.retainWhere((contact) {
        //store the searched item in a variable called searchItem
        String searchedItem = search.text.toLowerCase().trim();

        String searchTermFlattened = flattenedPhoneNumber(searchedItem);

        //create a variable to compare the searched Item to
        String contactName = contact.displayName!.toLowerCase();
        //searchBy contact
        bool nameMatches = contactName.contains(searchedItem);
        if (nameMatches == true) {
          return true;
        }
        if (searchTermFlattened.isNotEmpty) {
          return false;
        }

        var phone = contact.phones!.firstWhere((phn) {
          String phnFlattened = flattenedPhoneNumber(phn.value.toString());
          return phnFlattened.contains(searchTermFlattened);
        }, orElse: null);
        return phone != null;
      });
      setState(() {
        //update the UI
        contactFiltered = contact;
      });
    }
  }

  //removes the signs in a number
  String flattenedPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)/|D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  //get the contacts from the phone
  Future<void> getAllContacts() async {
    //create a temporary list storing the contacts
    List<Contact> temporaryContacts =
        (await ContactsService.getContacts()).toList();
    setState(() {
      //populate the list and update the UI
      contacts = temporaryContacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = search.text.isNotEmpty;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          content: Text(
            'Tap back again to leave',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            textAlign: TextAlign.center,
          ),
        ),
        child: SafeArea(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'images/one-small.png',
                      width: 390,
                      height: 218,
                      fit: BoxFit.cover,
                    ),
                    Reuse.speedDialHeader("Speed dial", context),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 0.0, left: 80, right: 80, top: 40),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          cursorWidth: 1,
                          autofocus: false,
                          autocorrect: true,
                          showCursor: true,
                          controller: search,
                          cursorColor: Theme.of(context).primaryColorLight,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                          decoration: InputDecoration(
                            hintText: "Enter your search",
                            hintStyle: TextStyle(
                                color: Theme.of(context).primaryColorLight),
                            fillColor:
                                Theme.of(context).primaryColor.withOpacity(.50),
                            filled: true,
                            label: Text(
                              "Search ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColorLight,
                              size: 30,
                            ),
                          ),
                          validator: (val) {
                            if (search.text.isNotEmpty) {
                              val = search.text;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Reuse.navigatorButton(
                                  Icon(
                                    Icons.emergency,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  () => Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (route) => false),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.group,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/settings', (route) => false);
                                  },
                                  icon: Icon(
                                    Icons.settings,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Reuse.title("Friends", context),
                const SizedBox(
                  height: 5,
                ),
                //title ends//
                (contacts.isEmpty)
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: (isSearching == true)
                              ? contactFiltered.length
                              : contacts.length,
                          itemBuilder: (context, index) {
                            //get the current contact index
                            Contact contact = (isSearching == true)
                                ? contactFiltered[index]
                                : contacts[index];
                            //get a particular phone
                            Uint8List? image = contact.avatar;

                            return SlidableAutoCloseBehavior(
                              //closes the slide when you open another
                              closeWhenOpened: true,
                              child: Slidable(
                                key: Key(contacts[index].toString()),
                                startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    extentRatio: .25,
                                    dismissible: DismissiblePane(
                                        onDismissed: () => false
                                        /*() async {
                                      List<Contact> tempCont =
                                          (await ContactsService.getContacts())
                                              .toList();
                                      setState(() {
                                        getAllContacts();
                                        contacts = tempCont;
                                      });
                                    }*/
                                        ),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          String nameTemporary = contact
                                              .displayName
                                              .toString()
                                              .trim();
                                          String phoneTemporary = contact
                                              .phones!
                                              .elementAt(0)
                                              .value
                                              .toString();

                                          display(
                                              nameTemporary, phoneTemporary);
                                        },
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        foregroundColor:
                                            Theme.of(context).primaryColorLight,
                                        icon: Icons.share,
                                        //label: 'Delete',
                                      ),
                                    ]),
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    extentRatio: .25,
                                    dismissible:
                                        DismissiblePane(onDismissed: () async {
                                      setState(() {
                                        contacts.remove(index);
                                      });
                                      List<Contact> tempCont =
                                          (await ContactsService.getContacts())
                                              .toList();

                                      if (tempCont.isNotEmpty) {
                                        contacts = tempCont;
                                        setState(() {
                                          getAllContacts();
                                          contacts = tempCont;
                                        });
                                      }
                                    }),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          //   delete contact

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Theme.of(context)
                                                .primaryColorDark,
                                            duration:
                                                const Duration(seconds: 2),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  " Do you want to delete? ",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorLight),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    //delete current contact

                                                    String deleteContact =
                                                        await ContactsService
                                                            .deleteContact(
                                                                contact);
                                                    List<Contact>
                                                        temporaryContact =
                                                        (await ContactsService
                                                                .getContacts())
                                                            .toList();
                                                    setState(() async {
                                                      deleteContact.toString();
                                                      temporaryContact =
                                                          contacts;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                          //__________________//
                                        },
                                        backgroundColor:
                                            Theme.of(context).primaryColorDark,
                                        foregroundColor:
                                            Theme.of(context).primaryColorLight,
                                        icon: Icons.delete,
                                        //label: 'Delete',
                                      ),
                                    ]),
                                child: InkWell(
                                  onDoubleTap: () async {
                                    try {
                                      /*String phoneNumber = contact.phones!
                                            .elementAt(0)
                                            .value
                                            .toString();*/

                                      await (FlutterPhoneDirectCaller
                                          .callNumber(
                                        contact.phones!
                                            .elementAt(0)
                                            .value
                                            .toString()
                                            .replaceAllMapped(
                                                RegExp(r'^(\+)/|D'), (Match m) {
                                          return m[0] == "+" ? "+" : "";
                                        }),
                                      )).whenComplete(() => const AddFriends());
                                    } on Exception catch (e) {
                                      // Anything else that is an exception
                                      print('Unknown exception: $e');
                                    }
                                  },
                                  onLongPress: () async {
                                    try {
                                      var update = await ContactsService
                                          .openExistingContact(contact);
                                      final changUpdate =
                                          await ContactsService.updateContact(
                                              update);

                                      setState(() async {
                                        await ContactsService.openContactForm();
                                        update = changUpdate;
                                      });
                                    } on FormOperationException catch (e) {
                                      switch (e.errorCode) {
                                        case FormOperationErrorCode
                                            .FORM_COULD_NOT_BE_OPEN:
                                          break;
                                        case FormOperationErrorCode
                                            .FORM_OPERATION_CANCELED:
                                          if (kDebugMode) {
                                            print(e.toString());
                                          }
                                          break;
                                        case FormOperationErrorCode
                                            .FORM_OPERATION_UNKNOWN_ERROR:
                                          if (kDebugMode) {
                                            print(e.toString());
                                          }
                                          break;
                                        default:
                                      }
                                    }
                                  },
                                  child: ListTile(
                                    onTap: () async {},
                                    leading: (image != null && image.isNotEmpty)
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(image),
                                          )
                                        : SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(.49),
                                              child: Text(
                                                contact.displayName![0].trim(),
                                              ),
                                            ),
                                          ),
                                    title: (contact.displayName == null &&
                                            contact.displayName!.isEmpty)
                                        ? Text(
                                            "No Name",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          )
                                        : Text(
                                            contact.displayName
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          ),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          /*IconButton(
                                            icon: const Icon(
                                              Icons.telegram,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            onPressed: () {},
                                          ),*/
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.whatsapp,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                String phoneTemporary = contact
                                                    .phones!
                                                    .elementAt(0)
                                                    .value
                                                    .toString();
                                                /*FlutterOpenWhatsapp
                                                    .sendSingleMessage(
                                                        phoneTemporary, "Hello");*/
                                                openWhatsApp(
                                                    phoneNumber: phoneTemporary,
                                                    message: 'Hello ');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(
                                      contact.phones!.isEmpty
                                          ? 'No Phone number'
                                          : contact.phones!
                                              .elementAt(0)
                                              .value
                                              .toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(.49)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                //title//
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColorDark,
              heroTag: "button_1",
              onPressed: () async {
                //get the contacts again
                setState(() {
                  //clear the textBox
                  search.clear();
                });
                //call the list
                await ContactsService.getContacts();
              },
              tooltip: 'refresh contact',
              child: Icon(Icons.refresh,
                  color: Theme.of(context).primaryColorLight),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColorDark,
            heroTag: "button_2",
            onPressed: () async {
              try {
                //open contact form to save contacts
                await ContactsService.openContactForm();

                //create a temporary list storing the contacts
                List<Contact> temporaryContacts =
                    (await ContactsService.getContacts()).toList();
                setState(() {
                  //populate the list and update the UI
                  contacts = temporaryContacts;
                });
              } on FormOperationException catch (e) {
                switch (e.errorCode) {
                  case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
                    break;
                  case FormOperationErrorCode.FORM_OPERATION_CANCELED:
                    if (kDebugMode) {
                      print(e.toString());
                    }
                    break;
                  case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
                    if (kDebugMode) {
                      print(e.toString());
                    }
                    break;
                  default:
                }
              }
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  display(String nameTemporary, String phoneTemporary) async {
    return await Share.share('$nameTemporary\n$phoneTemporary').then(
      (value) => Fluttertoast.showToast(
        msg: "Sharing contacts",
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryColorLight,
      ),
    );
  }

  Future<void> openWhatsApp({@required phoneNumber, @required message}) async {
    var url = Uri.parse("whatsapp://send?phone=$phoneNumber&text=$message");

    var whatsAppURl_android =
        Uri.parse("${"whatsApp://send?phone=" + phoneNumber}&text=$message");
    var whatsAppURL_ios =
        "https://wa.me/$phoneNumber?text=${Uri.parse("hello")}";

    /*search for checking platforms later*/
    await canLaunchUrl(whatsAppURl_android)
        ? launchUrl(whatsAppURl_android)
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
