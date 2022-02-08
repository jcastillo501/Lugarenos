import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lugarenos/screens/screenInfo/infoPlaces.dart';
import 'package:lugarenos/screens/views/components/Apis/place.dart';
import 'package:lugarenos/screens/views/viewMain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lugareños',
      home: ViewMain(),
    );
  }
}
