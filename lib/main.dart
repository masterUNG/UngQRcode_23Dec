import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungqrcode/states/add_account.dart';
import 'package:ungqrcode/states/authen.dart';
import 'package:ungqrcode/states/my_service.dart';
import 'package:ungqrcode/states/read_qr_code.dart';
import 'package:ungqrcode/utility/my_constant.dart';

Map<String, WidgetBuilder> map = {
  MyConstant.routeReadQRcode: (BuildContext context) => const ReadQRcode(),
  MyConstant.routeAuthen: (BuildContext context) => const Authen(),
  MyConstant.routeAddAccount: (BuildContext context) => const AddAccount(),
  MyConstant.routeMyService: (BuildContext context) => const MyService(),
};

String? firstState;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var data = preferences.getStringList('data');
  print('## data main ==>> $data');

  if (data == null) {
    firstState = MyConstant.routeAuthen;
    runApp(const MyApp());
  } else {
    firstState = MyConstant.routeMyService;
    runApp(const MyApp());
  }
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
