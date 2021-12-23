import 'package:flutter/material.dart';
import 'package:ungqrcode/states/read_qr_code.dart';

class ShowResultCode extends StatefulWidget {
  final String resultCode;
  const ShowResultCode({Key? key, required this.resultCode}) : super(key: key);

  @override
  _ShowResultCodeState createState() => _ShowResultCodeState();
}

class _ShowResultCodeState extends State<ShowResultCode> {
  String? resultCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultCode = widget.resultCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReadQRcode(),
                ),
                (route) => false),
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Show Result Code'),
      ),
      body: Center(child: Text(resultCode!)),
    );
  }
}
