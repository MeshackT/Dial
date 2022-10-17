/*
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipe/swipe.dart';

class ShareContact extends StatefulWidget {
  final String contactTemporary;
  final String nameTemporary;
  final Widget child;
  const ShareContact({
    Key? key,
    required this.contactTemporary,
    required this.nameTemporary,
    required this.child,
  }) : super(key: key);

  @override
  State<ShareContact> createState() => _ShareContactState();
}

class _ShareContactState extends State<ShareContact> {
  @override
  Widget build(BuildContext context) {
    String nameTemporary = '';
    String phoneTemporary = '';
    return Swipe(
      child: widget.child,
      onSwipeRight: () {
        setState(() async {
          */
/*show this when you share*/ /*

          Fluttertoast.showToast(
            msg: 'Share contact To',
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryColorLight,
          );
          await Share.share('$nameTemporary\n$phoneTemporary');
        });
      },
    );
  }
}
*/
