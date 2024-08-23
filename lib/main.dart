import 'package:flutter/material.dart';
import 'models/stopwatch_model.dart';
import 'presenters/stopwatch_presenter.dart';
import 'views/stopwatch_view.dart';

void main() {
  runApp(AnimatedStopwatchApp());
}

class AnimatedStopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget implements StopwatchView {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();

  @override
  void updateDisplay(String time) {
    // Implementado no estado
  }
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late StopwatchPresenter presenter;
  String displayTime = '00:00:00';

  @override
  void initState() {
    super.initState();
    presenter = StopwatchPresenter(StopwatchModel(), widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Stopwatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            displayTime,
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    presenter.startOrStop();
                  });
                },
                child: Text('Start/Stop'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    presenter.reset();
                  });
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void updateDisplay(String time) {
    setState(() {
      displayTime = time;
    });
  }
}