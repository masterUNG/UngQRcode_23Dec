import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungqrcode/utility/my_constant.dart';
import 'package:ungqrcode/widgets/show_text.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeAuthen, (route) => false));
          },
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: MyConstant.primary,
          ),
          title: ShowText(text: 'Sign Out', textStyle: MyConstant().h2Style()),
          subtitle: const ShowText(text: 'Sign Out and Move to Authen'),
          tileColor: MyConstant.light.withOpacity(0.4),
        ),
      ],
    );
  }
}
