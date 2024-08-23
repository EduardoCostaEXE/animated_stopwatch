import 'dart:async';
import '../models/stopwatch_model.dart';
import '../views/stopwatch_view.dart';

class StopwatchPresenter {
  final StopwatchModel model;
  final StopwatchView view;
  Timer? _timer;

  StopwatchPresenter(this.model, this.view);

  void startOrStop() {
    if (model.isRunning) {
      model.stop();
      _timer?.cancel();
    } else {
      model.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), _onTick);
    }
  }

  void reset() {
    model.reset();
    view.updateDisplay(_formatTime(model.elapsedTime));
  }

  void _onTick(Timer timer) {
    model.updateElapsedTime(Duration(milliseconds: 100));
    view.updateDisplay(_formatTime(model.elapsedTime));
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);
    return '$minutes:$seconds:$milliseconds';
  }
}