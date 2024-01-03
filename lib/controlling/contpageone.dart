import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class contpageone extends StatefulWidget {
  const contpageone({super.key});

  @override
  _contpageoneState createState() => _contpageoneState();
}

class _contpageoneState extends State<contpageone> {
  bool isSwitched = false;
  TextEditingController minTempController = TextEditingController();
  TextEditingController maxTempController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    minTempController.dispose();
    maxTempController.dispose();
    super.dispose();
  }

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  final DatabaseReference _suhuReference =
  FirebaseDatabase.instance.reference().child('suhuReq');


  void sendSwitchValueToFirebase(int value) {
    // Ganti "switchValue" dengan nama node yang sesuai di Firebase Database
    _databaseReference.child('onOff').set(value);
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
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
                      height: 230,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dehydrator",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                // Kirim data ke Firebase berdasarkan nilai switch
                                int onOff = isSwitched ? 1 : 0;
                                sendSwitchValueToFirebase(onOff);
                              });
                            },
                            activeColor: Colors.purple,
                            activeTrackColor: Colors.purple[200],
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
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
                      height: 180,
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
                                "Suhu",
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
                              child: Row(
                                children: [
                                  Column(
                                    children: [Text("Target")],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: minTempController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Suhu",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            // Handle input button click here
                                            String minTempText = minTempController.text;

                                            // Try to parse the input text as an integer
                                            int minTemp;
                                            if (int.tryParse(minTempText) != null) {
                                              minTemp = int.parse(minTempText);
                                            } else {
                                              // Handle the case where the input is not a valid integer
                                              _showNotificationDialog(context, 'Invalid input. Please enter a valid integer.');
                                              return; // Don't proceed with saving to Firebase
                                            }

                                            // Save the temperature value to Firebase
                                            _suhuReference.set(minTemp).then((_) {
                                              // Successfully updated the temperature, show a success pop-up
                                              _showSuccessDialog(context, 'Temperature updated successfully.');
                                            }).catchError((error) {
                                              // Handle any errors that may occur during the Firebase update
                                              print('Error updating temperature: $error');
                                            });

                                            // Optionally, you can also clear the input field after saving
                                            minTempController.clear();
                                          },
                                          child: Text('Input'))
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
            ],
          ),
        ),
      ),
    );
  }
}
