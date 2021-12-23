import 'package:flutter/material.dart';
import 'package:ungqrcode/utility/my_constant.dart';
import 'package:ungqrcode/widgets/show_image.dart';
import 'package:ungqrcode/widgets/show_text.dart';

class MyDialog {
  final Function()? funcAction;

  MyDialog({this.funcAction});

  Future<void> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const ShowImage(),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: message),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> actionDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const ShowImage(),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: message),
        ),
        actions: [
          TextButton(
            onPressed: funcAction,
            child: const Text('OK'),
          ),

         
        ],
      ),
    );
  }
}
