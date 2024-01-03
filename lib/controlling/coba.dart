import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: contpagetwo(),
  ));
}

class contpagetwo extends StatefulWidget {
  const contpagetwo({Key? key}) : super(key: key);

  @override
  _contpagetwoState createState() => _contpagetwoState();
}

class _contpagetwoState extends State<contpagetwo> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  late Timer timer;

  String get timerDisplay {
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, right: 5, left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Set Timer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TimerInput(
                            label: 'Jam',
                            value: hours,
                            onChanged: (value) {
                              setState(() {
                                hours = value;
                              });
                            },
                          ),
                          TimerInput(
                            label: 'Menit',
                            value: minutes,
                            onChanged: (value) {
                              setState(() {
                                minutes = value;
                              });
                            },
                          ),
                          TimerInput(
                            label: 'Detik',
                            value: seconds,
                            onChanged: (value) {
                              setState(() {
                                seconds = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _startTimer,
                        child: Text('Start Timer'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: 320,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Timer :',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        timerDisplay,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
void _startTimer() {
    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    if (totalSeconds > 0) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (totalSeconds > 0) {
            totalSeconds--;
            hours = totalSeconds ~/ 3600;
            minutes = (totalSeconds % 3600) ~/ 60;
            seconds = totalSeconds % 60;
          } else {
            timer.cancel();
          }
        });
      });
    }
  }
  // ... (kode lainnya sama seperti yang Anda berikan sebelumnya)
}

class TimerInput extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const TimerInput({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: () {
                onChanged(value - 1);
              },
              icon: Icon(Icons.remove),
            ),
            Text(value.toString()),
            IconButton(
              onPressed: () {
                onChanged(value + 1);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
