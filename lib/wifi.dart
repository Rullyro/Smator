import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'controlling.dart';
import 'dart:core';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
class wifi extends StatefulWidget {
  const wifi({super.key});

  @override
  _wifiState createState() => _wifiState();
}

class _wifiState extends State<wifi> {
  bool isSwitched = false;
  TextEditingController ssidc = TextEditingController();
  TextEditingController passc = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    ssidc.dispose();
    passc.dispose();
    super.dispose();
  }



  Future<void> _showNotificationDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showSuccessDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
      AppBar(title: Text('Pengaturan Wifi'), backgroundColor: Colors.purple),
      drawer: Drawer(
        child: Container(
          color: Colors.purple, // Warna ungu untuk sidebar
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'Monitoring',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: (() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard()))),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  'Controlling',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: (() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Controlling()))),
              ),
              ListTile(
                leading: Icon(
                  Icons.wifi,
                  color: Colors.white,
                ),
                title: Text(
                  'Setting Wifi',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: (() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => wifi()))),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                  child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: 270,
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Wifi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    Row(
                                        children: [
                                          Text("SSID"),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: ssidc,
                                              decoration: InputDecoration(
                                                hintText: "Masukkan Nama Wifi",
                                              ),
                                            ),
                                          ),
                                          ]
                                        ),
                                    Row(
                                        children: [
                                          Text("Pass"),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: passc,
                                              keyboardType: TextInputType.visiblePassword,
                                              decoration: InputDecoration(
                                                hintText: "Masukkan Password Wifi",
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                // Handle input button click here
                                                String ssidt = ssidc.text;
                                                String passt = passc.text;

                                                if (ssidt.isNotEmpty && passt.isNotEmpty) {
                                                  var url = Uri.http("192.168.4.1", '/wifisave', {'q': '{http}'});
                                                  try {
                                                    var response = await http.post(url, body: {
                                                      "s": ssidc.text,
                                                      "p": passc.text,
                                                    });

                                                    if (response.statusCode == 200) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Notification'),
                                                            content: Text('Wifi Tersimpan !'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  setState(() {
                                                                    ssidc.text = '';
                                                                    passc.text = '';
                                                                  }); // Close the dialog
                                                                },
                                                                child: Text('OK'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      // Handle HTTP request failure (non-200 status code)
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Notification'),
                                                            content: Text('Tidak dapat tersambung dengan wifi !'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  setState(() {
                                                                    ssidc.text = '';
                                                                    passc.text = '';
                                                                  }); // Close the dialog
                                                                },
                                                                child: Text('OK'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  } catch (error) {
                                                    // Handle network or other errors
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text('Notification'),
                                                          content: Text('Failed to connect to the server: $error'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                                setState(() {
                                                                  ssidc.text = '';
                                                                  passc.text = '';
                                                                }); // Close the dialog
                                                              },
                                                              child: Text('OK'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                } else {
                                                  // Handle the case where either SSID or password is empty
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Notification'),
                                                        content: Text('Both SSID and password are required.'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(); // Close the dialog
                                                            },
                                                            child: Text('OK'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: Text('Input'),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade600),
                                              ),
                                            )
                                          ],
                                        )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                )],
          ),
        ),
      ),
    );
  }
}
