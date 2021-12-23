import 'package:flutter/material.dart';
import 'package:ungqrcode/utility/my_constant.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() funcButton;
  const ShowButton({
    Key? key,
    required this.label,
    required this.funcButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: funcButton,
      child: Text(label),
    );
  }
}
