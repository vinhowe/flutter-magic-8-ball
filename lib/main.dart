import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake/shake.dart';

void main() => runApp(Magic8BallApp());

class Magic8BallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 Ball',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        canvasColor: Colors.purple,
        brightness: Brightness.dark,
      ),
      home: Magic8BallPage(title: 'Magic 8 Ball'),
    );
  }
}

class Magic8BallPage extends StatefulWidget {
  Magic8BallPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Magic8BallPageState createState() => _Magic8BallPageState();
}

class _Magic8BallPageState extends State<Magic8BallPage> {
  String message = "MAGIC 8 BALL";
  ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    Random random = new Random();

    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        message = random.nextDouble().toString();
      });
    }, shakeThresholdGravity: 1.25);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: OverflowBox(
              maxWidth: double.maxFinite,
              child: Material(
                type: MaterialType.circle,
                color: Colors.black,
                elevation: 30,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [Colors.white54, Colors.transparent],
                          stops: [0.05, 1],
                          radius: 1,
                          center: FractionalOffset(0.25, 0.25))),
                  child: SizedBox(
                    width: 500,
                    height: 500,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.iBMPlexMono(
                    textStyle: Theme.of(context).textTheme.display1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }
}
