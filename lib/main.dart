import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_8_ball/response_api.dart';
import 'package:shake/shake.dart';

void main() => runApp(Magic8BallApp());

class Magic8BallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 Ball',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        canvasColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: Magic8BallPage(title: 'Magic 8 Ball'),
    );
  }
}

class Magic8BallPage extends StatefulWidget {
  Magic8BallPage({Key key, this.title}) : super(key: key);

  final String title;
  static final String defaultMessage = "MAGIC 8 BALL";

  @override
  _Magic8BallPageState createState() => _Magic8BallPageState();
}

class _Magic8BallPageState extends State<Magic8BallPage> {
  ShakeDetector detector;
  ResponseApi api;

  @override
  void initState() {
    super.initState();
    api = ResponseApi();
    // Get initial answer
    newAnswer();

    detector = ShakeDetector.autoStart(
        onPhoneShake: () {
          newAnswer();
        },
        shakeThresholdGravity: 1.5);
  }

  void newAnswer() {
    api.fetchAnswer();
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
                child: InkWell(
                  onTap: newAnswer,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                            colors: [Colors.white54, Colors.transparent],
                            stops: [0.05, 1],
                            radius: 0.75,
                            center: FractionalOffset(0.25, 0.25))),
                    child: SizedBox(
                      width: 500,
                      height: 500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: StreamBuilder<String>(
                    stream: api.streamController.stream,
                    builder: (context, snapshot) {
                      String message;

                      if (snapshot.hasData) {
                        message = snapshot.data;
                      } else {
                        message = Magic8BallPage.defaultMessage;
                      }

                      return Text(
                        message.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.iBMPlexMono(
                            textStyle: Theme.of(context).textTheme.display1),
                      );
                    }),
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
    api.dispose();
    super.dispose();
  }
}
