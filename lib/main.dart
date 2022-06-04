import 'package:flutter/material.dart';
import 'package:flutter_application_1/balloon_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BalloonPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class BalloonPage extends StatefulWidget {
  const BalloonPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BalloonPage> createState() => _BalloonPageState();
}

class _BalloonPageState extends State<BalloonPage> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: deviceHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RootScreenBalloonSheet(),
          ],
        ),
      ),
    );
  }
}
