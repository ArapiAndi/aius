import 'package:align_ai/main.dart';
import 'package:align_ai/widgets/bar_chart.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'pose_capture.dart';
import 'pushed_pageS.dart';
import 'pushed_pageY.dart';

class MainScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  MainScreen(this.cameras);

  static const String id = 'main_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          FadeInDown(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'AIus',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'Traccia e Migliora la tua postura!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                    ),
                  ),
                )
              ])),
          SizedBox(height: 28),
          FadeInLeft(child: BarChartPoseTime()),
          SizedBox(height: 15),
          FadeInRight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 5),
                  child: Text(
                    'Allenamenti',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 150,
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 140,
                              height: 140,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                color: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.asset('images/crunch.PNG')),
                                onPressed: () {
                                  print('hello');
                                },
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 140,
                              height: 140,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  color: Colors.white,
                                  child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child:
                                          Image.asset('images/arm_press.PNG')),
                                  onPressed: () => print("Hello")),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 140,
                              height: 140,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                color: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.asset('images/push_up.PNG')),
                                onPressed: () {
                                  print('hello');
                                },
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 140,
                              height: 140,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  color: Colors.white,
                                  child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Image.asset('images/squat.PNG')),
                                  onPressed: () => print("ciao")),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 140,
                              height: 140,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                color: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.asset('images/plank.PNG')),
                                onPressed: () {
                                  print('hello');
                                },
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 140,
                              height: 140,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                color: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child:
                                        Image.asset('images/lunge_squat.PNG')),
                                onPressed: () {
                                  print('hello');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void onSelectA({BuildContext context, String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPageA(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}

void onSelectS({BuildContext context, String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPageS(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}

void onSelectY({BuildContext context, String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPageY(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}
