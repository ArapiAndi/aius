import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown/circular_countdown.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';

import 'package:align_ai/services/camera.dart';
import 'package:align_ai/services/render_pose_estimation.dart';
import 'package:wakelock/wakelock.dart';

class PushedPageA extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  const PushedPageA({this.cameras, this.title});
  @override
  _PushedPageAState createState() => _PushedPageAState();
}

class _PushedPageAState extends State<PushedPageA> {
  List<dynamic> _data;
  int _imageHeight = 0;
  int _imageWidth = 0;
  int x = 1;
  Color appBarColorNoRecording = Colors.green.shade200;
  Color appBarColorRecording = Color(0xff1abc9c);
  String appBarTextNoRecording = 'Premere per tracciare';
  String appBarTextRecording = 'Tracciamento della Postura';
  bool isRecording = false;
  bool isShowTimer = false;

  @override
  void initState() {
    super.initState();
    var res = loadModel();
    print('Model Response: ' + res.toString());
  }

  _setRecognitions(data, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _data = data;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  loadModel() async {
    return await Tflite.loadModel(
        model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                setState(() {
                  isRecording = !isRecording;
                  isShowTimer = isRecording;
                });
              },
              child: isRecording
                  ? Center(child: Text(appBarTextRecording))
                  : Center(child: Text(appBarTextNoRecording))),
          backgroundColor:
              isRecording ? appBarColorRecording : appBarColorNoRecording,
          elevation: 0,
          toolbarHeight: 65,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(55),
          ))),
      body: Stack(
        children: <Widget>[
          FadeInDown(
            child: Camera(
              cameras: widget.cameras,
              setRecognitions: _setRecognitions,
            ),
          ),
          isRecording
              ? (isShowTimer
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: TimeCircularCountdown(
                          textStyle: TextStyle(inherit: true, fontSize: 40),
                          unit: CountdownUnit.second,
                          countdownTotal: 4,
                          strokeWidth: 18,
                          countdownCurrentColor: Color(0xff1abc9c),
                          onUpdated: (unit, remainingTime) => print('Updated'),
                          onFinished: () => setState(() {
                            isShowTimer = false;
                          }),
                        ),
                      ),
                    )
                  : RenderDataPoseEstimation(
                      data: _data == null ? [] : _data,
                      previewH: max(_imageHeight, _imageWidth),
                      previewW: min(_imageHeight, _imageWidth),
                      screenH: screen.height,
                      screenW: screen.width,
                    ))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
