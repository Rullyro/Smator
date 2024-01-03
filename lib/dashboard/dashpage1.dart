import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class dashpage1 extends StatefulWidget {
  const dashpage1({Key? key}) : super(key: key);

  @override
  _dashpage1State createState() => _dashpage1State();
}

class _dashpage1State extends State<dashpage1> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.reference().child('suhuDehidrator');
  final DatabaseReference dbmin =
  FirebaseDatabase.instance.ref().child('menitBerakhir');
  final DatabaseReference dbhour =
  FirebaseDatabase.instance.ref().child('jamBerakhir');

  String suhu = 'Loading...';
  late int mins,hors;
  @override
  void initState() {
    super.initState();
    // Mengambil data dari Firebase saat widget diinisialisasi
    _dbRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        if (event.snapshot.value.toString().length == 1) {
          setState(() {
            suhu = '0${event.snapshot.value}';
          });
        } else {
          setState(() {
            suhu = '${event.snapshot.value}';
          });
        }
      } else {
        setState(() {
          suhu = 'Data tidak tersedia';
        });
      }

    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 550,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(50)),
            ),
            child: Column(
              children: [
                SizedBox(height: 70),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                    side: BorderSide(
                      color: Color.fromARGB(255, 234, 112, 255),
                      width: 7,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      width: 270,
                      height: 270,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Suhu",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${suhu.substring(0, 2)}°C', // Menampilkan nilai suhu dari Firebase
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Mengatur posisi di sebelah kanan
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Card(
                        color: Color.fromARGB(255, 138, 6, 161),
                        elevation: 0,
                        margin:
                            EdgeInsets.only(right: 20), // Mengatur margin kanan
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                          side: BorderSide(
                              color: Color.fromARGB(255, 231, 95, 255),
                              width: 4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            width: 120,
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Timer",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors
                                        .white, // Mengatur warna font menjadi putih
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "$hors:$mins",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // Mengatur warna font menjadi putih
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
