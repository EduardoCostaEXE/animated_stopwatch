class StopwatchModel {
  Duration elapsedTime = Duration.zero;
  bool isRunning = false;

  void start() {
    isRunning = true;
    // Lógica para iniciar o cronômetro
  }

  void stop() {
    isRunning = false;
    // Lógica para parar o cronômetro
  }

  void reset() {
    elapsedTime = Duration.zero;
    isRunning = false;
  }

  void updateElapsedTime(Duration time) {
    if (isRunning) {
      elapsedTime += time;
    }
  }
}