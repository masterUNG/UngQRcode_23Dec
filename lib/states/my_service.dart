import 'package:flutter/material.dart';
import 'package:ungqrcode/utility/my_constant.dart';
import 'package:ungqrcode/widgets/show_sign_out.dart';
import 'package:ungqrcode/widgets/show_text.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, MyConstant.routeReadQRcode),
            icon: const Icon(Icons.qr_code),
          ),
        ],
        backgroundColor: MyConstant.primary,
      ),
      drawer: const Drawer(
        child: ShowSignOut(),
      ),
      body: const ShowText(text: 'This is My Service'),
    );
  }
}
