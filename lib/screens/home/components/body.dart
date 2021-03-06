import 'package:flutter/material.dart';
import 'package:lugarenos/screens/home/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/fondo.png",
            height: 180,
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
