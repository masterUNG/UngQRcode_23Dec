import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ungqrcode/states/show_result_code.dart';

class ReadQRcode extends StatefulWidget {
  const ReadQRcode({Key? key}) : super(key: key);

  @override
  _ReadQRcodeState createState() => _ReadQRcodeState();
}

class _ReadQRcodeState extends State<ReadQRcode> {
  String? resultCode;
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? qrViewController;

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read QR code'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: 200,
          height: 250,
          // color: Colors.grey,
          child: QRView(
            key: qrKey,
            onQRViewCreated: (QRViewController qrViewController) {
              this.qrViewController = qrViewController;
              qrViewController.scannedDataStream.listen((event) {
                resultCode = event.code;
                // ignore: avoid_print
                print('resultCode ==>> $resultCode');

                // ignore: unnecessary_null_comparison
                if (event != null) {
                  qrViewController.stopCamera();
                }

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShowResultCode(resultCode: resultCode!),
                    ),
                    (route) => false);
              });
            },
          ),
        ),
      ),
    );
  }
}
