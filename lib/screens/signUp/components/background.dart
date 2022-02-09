import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -100,
              right: -220,
              child: Image.asset("assets/images/Top.png")),
          Positioned(
              bottom: -300,
              left: -600,
              child: Image.asset("assets/images/bottom.png")),
          child,
        ],
      ),
    );
  }
}
