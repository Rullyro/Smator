import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:provider/provider.dart';


class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;

  bool get isRunning => _timer != null && _timer!.isActive;

  String get timerDisplay {
    return '$_hours:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}';
  }

  // Metode setter untuk mengatur nilai hours, minutes, dan seconds
  void setHours(int value) {
    _hours = value;
    notifyListeners(); // Memberi tahu listener bahwa nilai telah berubah
  }

  void setMinutes(int value) {
    _minutes = value;
    notifyListeners();
  }

  void setSeconds(int value) {
    _seconds = value;
    notifyListeners();
  }

  void startTimer() {
    int totalSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    if (totalSeconds > 0 && !isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (totalSeconds > 0) {
          totalSeconds--;
          _hours = totalSeconds ~/ 3600;
          _minutes = (totalSeconds % 3600) ~/ 60;
          _seconds = totalSeconds % 60;
          notifyListeners();
        } else {
          _timer!.cancel();
          _timer = null;
          notifyListeners();
        }
      });
    }
  }

  void stopTimer() {
    if (isRunning) {
      _timer!.cancel();
      _timer = null;
      notifyListeners();
    }
  }

  void restartTimer() {
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    stopTimer();
  }
}
