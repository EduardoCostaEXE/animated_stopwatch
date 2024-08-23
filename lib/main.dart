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

class _StopwatchScreenState extends State<StopwatchScreen>
    with SingleTickerProviderStateMixin
    implements StopwatchView {
  late StopwatchPresenter presenter;
  String displayTime = '00:00:00';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    presenter = StopwatchPresenter(StopwatchModel(), this);
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void updateDisplay(String time) {
    _animationController.forward().then((_) {
      setState(() {
        displayTime = time;
        _animationController.reverse();
      });
    });
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
          FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              displayTime,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}