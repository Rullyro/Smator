import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semator/components/mybuttonsign.dart';
import 'package:semator/components/mytextfields.dart';
import 'package:semator/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
        final storedPassword = userData['password'];
        if (password == storedPassword) {
          // Login berhasil
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('error'),
                  content: Text('Password Salah.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'),
                    )
                  ],
                );
              });
        }
        ;
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Username tidak ditemukan.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Kesalahan lain
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                //logo
                Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.purple[800],
                ),

                SizedBox(
                  height: 30,
                ),

                Text(
                  "Silakan login terlebih dahulu",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.purple[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                mytextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                //textf

                SizedBox(
                  height: 15,
                ),

                mytextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                myButtonSign(
                  onPressed: () => loginUser(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
