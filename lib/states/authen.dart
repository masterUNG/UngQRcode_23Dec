import 'package:flutter/material.dart';
import 'package:ungqrcode/utility/my_constant.dart';
import 'package:ungqrcode/widgets/show_button.dart';
import 'package:ungqrcode/widgets/show_form.dart';
import 'package:ungqrcode/widgets/show_image.dart';
import 'package:ungqrcode/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: MyConstant.primary,
        onPressed: () => Navigator.pushNamed(context, MyConstant.routeAddAccount),
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(builder: (context, constarin) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Container(decoration: MyConstant().planBox(),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      newImage(constarin),
                      newAppName(),
                      newUser(constarin),
                      newPassword(constarin),
                      newLogin(constarin),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Container newLogin(BoxConstraints constarin) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: constarin.maxWidth * 0.6,
      child: ShowButton(
        label: 'Login',
        funcButton: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            print('user ==> $user, password = $password');
          }
        },
      ),
    );
  }

  Container newUser(BoxConstraints constarin) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constarin.maxWidth * 0.6,
      // height: 40,
      child: ShowForm(
        label: 'User :',
        iconData: Icons.perm_identity,
        formValidate: userValidate,
        formSave: (String? string) {
          user = string!.trim();
        },
      ),
    );
  }

  String? userValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill User in Blank';
    } else {
      return null;
    }
  }

  String? passwordValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill Password in Blank';
    } else {
      return null;
    }
  }

  Container newPassword(BoxConstraints constarin) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constarin.maxWidth * 0.6,
      // height: 40,
      child: ShowForm(
        label: 'Password :',
        iconData: Icons.lock_outline,
        secureText: true,
        formValidate: passwordValidate,
        formSave: (String? string) {
          password = string!.trim();
        },
      ),
    );
  }

  ShowText newAppName() {
    return ShowText(
      text: MyConstant.appName,
      textStyle: MyConstant().h1Style(),
    );
  }

  SizedBox newImage(BoxConstraints constarin) {
    return SizedBox(
      width: constarin.maxWidth * 0.6,
      child: const ShowImage(),
    );
  }
}
