import 'package:align_ai/account_screen.dart';
import 'package:align_ai/main.dart';
import 'package:align_ai/pose_capture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:camera/camera.dart';

import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomeScreen(this.cameras);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MainScreen(cameras),
    PushedPageA(cameras: cameras, title: 'posenet'),
    AccountView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              height: 40,
            ),
            title: Text('Training'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: SvgPicture.asset(
              "assets/icons/camera.svg",
              height: 40,
              width: 40,
            ),
            title: Text('Camera'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/settings.svg",
              height: 40,
              width: 40,
            ),
            title: Text('Monitor'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        elevation: 0.0,
        onTap: _onItemTapped,
      ),
    );
  }
}
