import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class intro3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 130, right: 20, left: 20),
            child: Text(
              'MONITORING',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Colors.purple[700],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Memudahkan anda untuk memonitoring dehydrator anda dengan indikator suhu, kelembapan dan waktu yang dibutuhkan untuk mengeringkan bahan pangan',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 2),
              textAlign: TextAlign.justify,
            ),
          ),
          Center(
            child: Image(
              image: AssetImage('assets/img/intro3.png'),
              height: 300,
              width: 300,
            ),
          )
        ],
      ),
    );
  }
}
