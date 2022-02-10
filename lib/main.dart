import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lugarenos/screens/views/viewMain.dart';

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
      home: ViewMain(),
    );
  }
}
