import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class contpagetwo extends StatefulWidget {
  const contpagetwo({Key? key}) : super(key: key);

  @override
  _contpagetwoState createState() => _contpagetwoState();
}

class _contpagetwoState extends State<contpagetwo> {
  late Timer timer;
  final DatabaseReference dbmin =
  FirebaseDatabase.instance.ref().child('menitBerakhir');
  final DatabaseReference dbhour =
  FirebaseDatabase.instance.ref().child('jamBerakhir');
  final DatabaseReference dbmins =
  FirebaseDatabase.instance.ref().child('menitMulai');
  final DatabaseReference dbhours =
  FirebaseDatabase.instance.ref().child('jamMulai');

  late int mins,minsa, hors,horsa;
  late int jamValue = 0; // Initialize jamValue to 0
  late int menitValue = 0; // Initialize menitValue to 0

  void initState() {
    super.initState();
    dbmin.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          mins = int.parse(event.snapshot.value.toString());
        });
      } else {
        setState(() {
          mins = 0;
        });
      }
    });
    dbhour.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          hors = int.parse(event.snapshot.value.toString());
        });
      } else {
        setState(() {
          hors = 0;
        });
      }
    });
    dbmins.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          minsa = int.parse(event.snapshot.value.toString());
        });
      } else {
        setState(() {
          minsa = 0;
        });
      }
    });
    dbhours.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          horsa = int.parse(event.snapshot.value.toString());
        });
      } else {
        setState(() {
          horsa = 0;
        });
      }
    });
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                            value: jamValue,
                            onChanged: (value) {
                              setState(() {
                                jamValue = value;
                              });
                            },
                          ),
                          TimerInput(
                            label: 'Menit',
                            value: menitValue,
                            onChanged: (value) {
                              setState(() {
                                menitValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          startTimer(jamValue, menitValue);
                        },
                        child: Text('Start Timer'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          stopAndRestartTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[600],
                        ),
                        child: Text(
                          'Stop & Restart Timer',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Timer',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Waktu Mulai :',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$horsa : $minsa',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Waktu Berakhir :',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$hors : $mins',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
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

  void startTimer(int newHours, int newMinutes) {
    DateTime currentTime = DateTime.now();
    int JamSek = currentTime.hour;
    int MinSek = currentTime.minute;
    dbhours.set(JamSek);
    dbmins.set(MinSek);
    dbhour.set(newHours);
    dbmin.set(newMinutes);
    setState(() {
      jamValue = 0;
      menitValue = 0;
    });
  }

  void stopAndRestartTimer() {
    DateTime currentTime = DateTime.now();
    DateTime newTime = currentTime.add(Duration(minutes: 5));
    int newHour = newTime.hour;
    int newMinute = newTime.minute;
    int JamSek = 0;
    int MinSek = 0;
    dbhours.set(JamSek);
    dbmins.set(MinSek);
    dbhour.set(newHour);
    dbmin.set(newMinute);
    setState(() {
      jamValue = 0;
      menitValue = 0;
    });
  }
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
                if (value > 0) {
                  onChanged(value - 1);
                }
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
