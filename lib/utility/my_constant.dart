import 'package:flutter/material.dart';

class MyConstant {
  // field
  static String appName = 'Ung QR code';

  static String routeReadQRcode = '/readQRcode';
  static String routeAuthen = '/authen';
  static String routeAddAccount = '/addAccount';

  static Color primary = const Color(0xff65039e);
  static Color dark = const Color(0xff31006e);
  static Color light = const Color(0xff9841d0);

  // Method or Function
  BoxDecoration planBox() => BoxDecoration(color: light.withOpacity(0.7));

  BoxDecoration whiteBox() => const BoxDecoration(color: Colors.white60);

  TextStyle h1Style() => TextStyle(
        color: dark,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        color: dark,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        color: dark,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}
