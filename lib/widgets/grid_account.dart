import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountImages extends StatelessWidget {
  const AccountImages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(50, (index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('AccountImage',
                      "assets/accounts_image/" + index.toString() + ".svg");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'Homepage', (Route<dynamic> route) => false);
                },
                child: SvgPicture.asset(
                  "assets/accounts_image/" + index.toString() + ".svg",
                  height: 20,
                  width: 20,
                )),
          );
        }),
      ),
    );
  }
}
