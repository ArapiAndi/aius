import 'package:align_ai/widgets/grid_account.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountView extends StatefulWidget {
  const AccountView();

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountView> {
  Future<String> getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('AccountImage');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  FadeInDown(
                      from: 100,
                      duration: Duration(milliseconds: 1000),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 135,
                            height: 135,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccountImages()),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: ClipOval(
                                    child: SvgPicture.asset(
                                        "assets/accounts_image/49.svg",
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ))),
                  SizedBox(height: 10),
                  FadeInRight(
                    child: SettingsSection(
                      tiles: [
                        SettingsTile(
                          title: 'Username',
                          subtitle: "Andi",
                          leading: Icon(Icons.account_circle),
                          onPressed: (BuildContext context) {},
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}
