import 'package:flutter/material.dart';
import 'package:ungqrcode/utility/my_constant.dart';
import 'package:ungqrcode/widgets/show_button.dart';
import 'package:ungqrcode/widgets/show_form.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Add New Account'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                buildFormField(
                  constraints,
                  Icons.fingerprint,
                  'Name :',
                  nameValidate,
                  nameSave,
                ),
                buildFormField(
                  constraints,
                  Icons.perm_identity,
                  'User :',
                  userValidate,
                  userSave,
                ),
                buildFormField(
                  constraints,
                  Icons.lock_outline,
                  'Password :',
                  passwordValidate,
                  passwordSave,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      width: constraints.maxWidth * 0.6,
                      child: ShowButton(
                          label: 'Add New Account',
                          funcButton: processAddAccount),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void processAddAccount() {
    if (formKey.currentState!.validate()) {}
  }

  Row buildFormField(
    BoxConstraints constraints,
    IconData iconData,
    String label,
    String? Function(String? string) funcValidate,
    Function(String? string),
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: ShowForm(
            label: label,
            iconData: iconData,
            formValidate: funcValidate,
            formSave: nameSave,
          ),
        ),
      ],
    );
  }

  void nameSave(String? string) {}

  void userSave(String? string) {}

  void passwordSave(String? string) {}

  String? nameValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill Name';
    } else {
      return null;
    }
  }

  String? userValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill User';
    } else {
      return null;
    }
  }

  String? passwordValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill Password';
    } else {
      return null;
    }
  }
}
