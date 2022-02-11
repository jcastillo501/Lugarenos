import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lugarenos/screens/home/components/welcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.apps;
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lugareños',
      home: WelcomeScreen(),
    );
  }
}
