import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:semator/controlling/timerprovider.dart';
import 'package:semator/onboardingscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase

  runApp(
    ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: onboardingscreen(),
      ),
    ),
  );
}
