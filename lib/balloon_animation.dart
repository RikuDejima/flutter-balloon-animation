import 'dart:async';
import 'dart:math' as math;
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@immutable
class _Point {
  final double x;
  final double y;
  final Color color;
  final double radius;
  final Duration duration;
  final Curve curve;

  _Point({
    required this.x,
    required this.y,
    required this.color,
    required this.radius,
    required this.duration,
    required this.curve,
  });
}

class RootScreenBalloonSheet extends StatefulWidget {
  @override
  _RootScreenBalloonSheetState createState() => _RootScreenBalloonSheetState();
}

class _RootScreenBalloonSheetState extends State<RootScreenBalloonSheet> {
  final Duration animateDuration = Duration(milliseconds: 1200);
  final Duration animateFixedDuration = Duration(milliseconds: 1000);
  final Curve animateCurve = Curves.linear;
  final Curve animateFixedCurve = Curves.easeOut;
  final maxIndex = 4;
  bool isFluttering = true;

  double position1X = 55.0;
  double position1Y = 60.0;

  double position2X = 70.0;
  double position2Y = 300.0;

  double position3X = 250.0;
  double position3Y = 200.0;

  double position4X = 270.0;
  double position4Y = 200.0;

  double position5X = 400.0;
  double position5Y = 250.0;

  @override
  void initState() {
    startChangingBalloonXY();
    super.initState();
  }

  double createRandomPosition({required int min, required int max}) {
    var random = math.Random();
    return (min + (random.nextInt(max - min))).toDouble();
  }

  void startChangingBalloonXY() async {
    while (isFluttering) {
      setState(() {
        position1X = createRandomPosition(min: -10, max: 80);
        position1Y = createRandomPosition(min: 40, max: 140);
        position2X = createRandomPosition(min: 50, max: 170);
        position2Y = createRandomPosition(min: 270, max: 350);
        position3X = createRandomPosition(min: 170, max: 240);
        position3Y = createRandomPosition(min: 90, max: 230);
        position4X = createRandomPosition(min: 200, max: 300);
        position4Y = createRandomPosition(min: -10, max: 100);
        position5X = createRandomPosition(min: 300, max: 400);
        position5Y = createRandomPosition(min: 300, max: 370);
      });
      await Future.delayed(animateDuration);
    }
  }

  List<_Point> getBalloonPositions(
    double deviceHeight,
    double deviceWidth,
  ) {
    if (isFluttering) {
      return [
        _Point(
          x: position1X,
          y: position1Y,
          color: Color(0XFF6BE89B),
          radius: 60,
          duration: animateDuration,
          curve: animateCurve,
        ),
        _Point(
          x: position2X,
          y: position2Y,
          color: Color(0XFF38C7BD),
          radius: 61,
          duration: animateDuration,
          curve: animateCurve,
        ),
        _Point(
          x: position3X,
          y: position3Y,
          color: Color(0XFF6BE89B),
          radius: 41,
          duration: animateDuration,
          curve: animateCurve,
        ),
        _Point(
          x: position4X,
          y: position4Y,
          color: Color(0XFFFFF041),
          radius: 54,
          duration: animateDuration,
          curve: animateCurve,
        ),
        _Point(
          x: position5X,
          y: position5Y,
          color: Color(0XFFFFC031),
          radius: 31,
          duration: animateDuration,
          curve: animateCurve,
        ),
      ];
    } else {
      return [
        _Point(
          x: deviceWidth / 2 - 42,
          y: deviceHeight - 448,
          color: Color(0XFF6BE89B),
          radius: 60,
          duration: animateFixedDuration,
          curve: animateFixedCurve,
        ),
        _Point(
          x: deviceWidth / 2 - 67,
          y: deviceHeight - 390,
          color: Color(0XFF38C7BD),
          radius: 61,
          duration: animateFixedDuration,
          curve: animateFixedCurve,
        ),
        _Point(
          x: deviceWidth / 2 + 10,
          y: deviceHeight - 472,
          color: Color(0XFF6BE89B),
          radius: 41,
          duration: animateFixedDuration,
          curve: animateFixedCurve,
        ),
        _Point(
          x: deviceWidth / 2 + 35,
          y: deviceHeight - 435,
          color: Color(0XFFFFF041),
          radius: 54,
          duration: animateFixedDuration,
          curve: animateFixedCurve,
        ),
        _Point(
          x: deviceWidth / 2 + 70,
          y: deviceHeight - 400,
          color: Color(0XFFFFC031),
          radius: 31,
          duration: animateFixedDuration,
          curve: animateFixedCurve,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // startChangingBalloonXY();

    return Stack(
      children: [
        for (final p in getBalloonPositions(
          MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width,
        ))
          AnimatedPositioned(
            left: p.x,
            top: p.y,
            duration: p.duration,
            curve: p.curve,
            child: CustomPaint(
              painter: _CirclePainter(color: p.color, radius: p.radius),
            ),
          ),
      ],
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;
  final double radius;

  _CirclePainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(0, 0), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
