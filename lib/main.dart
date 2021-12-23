import 'package:flutter/material.dart';
import 'package:ungqrcode/states/add_account.dart';
import 'package:ungqrcode/states/authen.dart';
import 'package:ungqrcode/states/read_qr_code.dart';
import 'package:ungqrcode/utility/my_constant.dart';

Map<String, WidgetBuilder> map = {
  MyConstant.routeReadQRcode: (BuildContext context) => const ReadQRcode(),
  MyConstant.routeAuthen: (BuildContext context) => const Authen(),
  MyConstant.routeAddAccount: (BuildContext context) => const AddAccount(),
};

String? firstState;

void main() {
  firstState = MyConstant.routeAuthen;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: firstState,
    );
  }
}
