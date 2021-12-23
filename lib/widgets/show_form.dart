import 'package:flutter/material.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool? secureText;
  final String? Function(String?) formValidate;
  final Function(String?) formSave;
  const ShowForm({
    Key? key,
    required this.label,
    required this.iconData,
    this.secureText,
    required this.formValidate,
    required this.formSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: formSave,
      validator: formValidate,
      obscureText: secureText ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white60,
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        prefixIcon: Icon(iconData),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: label,
      ),
    );
  }
}
