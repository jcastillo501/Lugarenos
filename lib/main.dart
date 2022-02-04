import 'package:flutter/material.dart';
import 'package:lugarenos/screens/views/viewMain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'AmazingSlabTrial-Bold'),
      title: 'Lugareños',
      home: ViewMain(),
    );
  }
}
