import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Step Simple Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Step Simple Counter'),
    );
  }
}
final _streamSubscriptions = <StreamSubscription<dynamic>>[];
StreamSubscription? _accelerometerStreamSubscription;
int stepCounter = 0;
double previousvalue = 0.0;
bool _isStepUp = false;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
void initState() {
  _initcountAccelerometer();
}


@override
void dispose() {
  _stopcountAccelerometer();
}


void _initcountAccelerometer() {
  _accelerometerStreamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
    double y = event.y;
    double magnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    double delta = magnitude - previousvalue;


    if (delta > 2.0 && !_isStepUp && magnitude > 11.0) {
      stepCounter;
      _isStepUp = true;
        stepCounter = stepCounter;
    } else if (delta < -2.0) {
      _isStepUp = false;
    }

    previousvalue = magnitude;
  });
}


void _stopcountAccelerometer() {
  _accelerometerStreamSubscription?.cancel();
  _accelerometerStreamSubscription = null;
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Step Counter'),
    ),
    body: Center(
      child: Text(
        'the step counter for the user: $stepCounter',style: TextStyle(fontSize: 30),
      ),
    ),
  );
}
}
