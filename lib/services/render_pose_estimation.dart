import 'package:flutter/material.dart';
import 'dart:math';

class RenderDataPoseEstimation extends StatefulWidget {
  final List<dynamic> data;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  RenderDataPoseEstimation({
    this.data,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
  });
  @override
  _RenderDataPoseEstimationState createState() =>
      _RenderDataPoseEstimationState();
}

class _RenderDataPoseEstimationState extends State<RenderDataPoseEstimation> {
  Map<String, List<double>> inputArr;

  bool isFirstTime = true;
  double distanceShoulderNose = 0.0;
  double distanceNSRL = 20;
  double percenstageDistance = 0.60;

  double slopeShoulder = 0;
  double slopeEyes = 0;
  double upperRange = 300;
  double lowerRange = 500;
  bool midCount, isCorrectPosture;
  Color correctColor;
  double shoulderLY, shoulderRY;
  double wristLX, wristLY, wristRX, wristRY, elbowLX, elbowRX;
  double kneeRY, kneeLY;
  double slopeCondition = 0.15;

  var leftEyePos = Vector(0, 0);
  var rightEyePos = Vector(0, 0);
  var nose = Vector(0, 0);
  var leftShoulderPos = Vector(0, 0);
  var rightShoulderPos = Vector(0, 0);
  var leftHipPos = Vector(0, 0);
  var rightHipPos = Vector(0, 0);
  var leftElbowPos = Vector(0, 0);
  var rightElbowPos = Vector(0, 0);
  var leftWristPos = Vector(0, 0);
  var rightWristPos = Vector(0, 0);
  var leftKneePos = Vector(0, 0);
  var rightKneePos = Vector(0, 0);
  var leftAnklePos = Vector(0, 0);
  var rightAnklePos = Vector(0, 0);

  double getDistancePoints(p1, p2, isDistorted) {
    double px = p1.x;
    double py = p1.y;
    if (isDistorted) {
      px = px - 280;
      py = py - 80;
    }
    double distanceX = px - p2.x;
    double distanceY = py - p2.y;
    return sqrt(pow(distanceX, 2) + pow(distanceY, 2));
  }

  @override
  void initState() {
    inputArr = new Map();
    midCount = false;
    isCorrectPosture = false;
    correctColor = Colors.green.shade100;
    shoulderLY = 0;
    shoulderRY = 0;
    kneeRY = 0;
    kneeLY = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _getKeyPoints(k, x, y) {
      if (k["part"] == 'leftEye') {
        leftEyePos.x = x - 280;
        leftEyePos.y = y - 100;
      }
      if (k["part"] == 'rightEye') {
        rightEyePos.x = x - 280;
        rightEyePos.y = y - 100;
      }

      if (k["part"] == 'nose') {
        nose.x = x - 280;
        nose.y = y - 100;
      }

      if (k["part"] == 'leftShoulder') {
        leftShoulderPos.x = x - 280;
        leftShoulderPos.y = y - 100;
      }
      if (k["part"] == 'rightShoulder') {
        rightShoulderPos.x = x - 280;
        rightShoulderPos.y = y - 100;
      }
      if (k["part"] == 'leftElbow') {
        leftElbowPos.x = x - 280;
        leftElbowPos.y = y - 100;
      }
      if (k["part"] == 'rightElbow') {
        rightElbowPos.x = x - 280;
        rightElbowPos.y = y - 100;
      }
      if (k["part"] == 'leftWrist') {
        leftWristPos.x = x - 280;
        leftWristPos.y = y - 100;
      }
      if (k["part"] == 'rightWrist') {
        rightWristPos.x = x - 280;
        rightWristPos.y = y - 100;
      }
      if (k["part"] == 'leftHip') {
        leftHipPos.x = x - 280;
        leftHipPos.y = y - 100;
      }
      if (k["part"] == 'rightHip') {
        rightHipPos.x = x - 280;
        rightHipPos.y = y - 100;
      }
      if (k["part"] == 'leftKnee') {
        leftKneePos.x = x - 280;
        leftKneePos.y = y - 100;
      }
      if (k["part"] == 'rightKnee') {
        rightKneePos.x = x - 280;
        rightKneePos.y = y - 100;
      }
      if (k["part"] == 'leftAnkle') {
        leftAnklePos.x = x - 280;
        leftAnklePos.y = y - 100;
      }
      if (k["part"] == 'rightAnkle') {
        rightAnklePos.x = x - 280;
        rightAnklePos.y = y - 100;
      }
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      widget.data.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (widget.screenH / widget.screenW >
              widget.previewH / widget.previewW) {
            scaleW = widget.screenH / widget.previewH * widget.previewW;
            scaleH = widget.screenH;
            var difW = (scaleW - widget.screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = widget.screenW / widget.previewW * widget.previewH;
            scaleW = widget.screenW;
            var difH = (scaleH - widget.screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          inputArr[k['part']] = [x, y];
          //Mirroring
          if (x > 320) {
            var temp = x - 320;
            x = 320 - temp;
          } else {
            var temp = 320 - x;
            x = 320 + temp;
          }

          _getKeyPoints(k, x, y);

          if (isFirstTime) {
            double distanceR = getDistancePoints(nose, rightShoulderPos, true);
            double distanceL = getDistancePoints(nose, leftShoulderPos, true);
            if ((distanceL - distanceR).abs() <= distanceNSRL) {
              distanceShoulderNose = distanceR;
              isFirstTime = false;
            }
          }

          if (k["part"] == 'leftEye') {
            leftEyePos.x = x - 280;
            leftEyePos.y = y - 80;
          }
          if (k["part"] == 'rightEye') {
            rightEyePos.x = x - 280;
            rightEyePos.y = y - 80;
          }

          if (k["part"] == 'nose') {
            nose.x = x - 280;
            nose.y = y - 80;
          }

          return Positioned(
            left: x - 280,
            top: y - 50,
            width: 100,
            height: 15,
            child: Container(
                // child: Text(
                //   "● ${k["part"]}",
                //   style: TextStyle(
                //     color: Color.fromRGBO(37, 213, 253, 1.0),
                //     fontSize: 12.0,
                //   ),
                // ),
                ),
          );
        }).toList();

        inputArr.clear();

        lists..addAll(list);
      });
      slopeEyes =
          (leftEyePos.y - rightEyePos.y) / (leftEyePos.x - rightEyePos.x);
      slopeShoulder = (leftShoulderPos.y - rightShoulderPos.y) /
          (leftShoulderPos.x - rightShoulderPos.x);

      return lists;
    }

    print(getDistancePoints(nose, rightShoulderPos, false));
    print(getDistancePoints(nose, leftShoulderPos, false));
    print(distanceShoulderNose);
    correctColor = ((slopeEyes).abs() <= slopeCondition &&
                (slopeShoulder).abs() <= slopeCondition) &&
            (getDistancePoints(nose, rightShoulderPos, false) >=
                distanceShoulderNose * percenstageDistance)
        ? Colors.green
        : Colors.blue;
    return Stack(
      children: <Widget>[
        Stack(
          children: [
            CustomPaint(
              painter:
                  MyPainter(left: leftEyePos, right: nose, color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: nose, right: rightEyePos, color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftShoulderPos,
                  right: rightShoulderPos,
                  color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftElbowPos,
                  right: leftShoulderPos,
                  color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftWristPos, right: leftElbowPos, color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightElbowPos,
                  right: rightShoulderPos,
                  color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightWristPos,
                  right: rightElbowPos,
                  color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftShoulderPos,
                  right: leftHipPos,
                  color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftHipPos, right: leftKneePos, color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftKneePos, right: leftAnklePos, color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightShoulderPos,
                  right: rightHipPos,
                  color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightHipPos, right: rightKneePos, color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: rightKneePos,
                  right: rightAnklePos,
                  color: correctColor),
            ),
            CustomPaint(
              painter: MyPainter(
                  left: leftHipPos, right: rightHipPos, color: correctColor),
            ),
          ],
        ),
        Stack(children: _renderKeypoints()),
      ],
    );
  }
}

class Vector {
  double x, y;
  Vector(this.x, this.y);
}

class MyPainter extends CustomPainter {
  Vector left;
  Vector right;
  Color color;
  MyPainter({this.left, this.right, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(left.x, left.y);
    final p2 = Offset(right.x, right.y);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
