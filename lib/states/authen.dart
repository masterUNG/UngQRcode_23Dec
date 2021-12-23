import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungqrcode/models/user_model.dart';
import 'package:ungqrcode/utility/my_constant.dart';
import 'package:ungqrcode/utility/my_dialog.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.primary,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddAccount),
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(builder: (context, constarin) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: MyConstant().planBox(),
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
        funcButton: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            print('user ==> $user, password = $password');

            String path =
                'https://www.androidthai.in.th/bigc/getUserWhereUserUng.php?isAdd=true&user=$user';
            await Dio().get(path).then((value) async {
              print('## value authe ==> $value');
              if (value.toString() == 'null') {
                MyDialog().normalDialog(
                    context, 'User False ?', 'No $user in my Database');
              } else {
                for (var item in json.decode(value.data)) {
                  UserModel model = UserModel.fromMap(item);
                  if (password == model.password) {
                    // List<String> datas = [];
                    var datas = <String>[];
                    datas.add(model.id);
                    datas.add(model.name);
                    datas.add(model.user);
                    datas.add(model.password);
                    datas.add(model.lat);
                    datas.add(model.lng);
                    datas.add(model.token);

                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setStringList('data', datas).then((value) {
                      MyDialog(
                        funcAction: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            MyConstant.routeMyService,
                            (route) => false),
                      ).actionDialog(
                          context, 'Welcome ${model.name}', 'Have a Nice Day');
                    });
                  } else {
                    MyDialog().normalDialog(
                        context, 'Password False ?', 'Please try again');
                  }
                }
              }
            });
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
