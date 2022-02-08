import 'package:flutter/material.dart';
import 'package:lugarenos/screens/login/components/background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Background(
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 250,
              right: 105,
              child: Image.asset(
                "assets/images/fondo.png",
                height: screenHeight * 0.05,
              )),
          const Positioned(
              top: 350,
              right: 100,
              child: Text('Ingresa con tu email y contraseña')),
          Container(
            margin: const EdgeInsets.only(top: 450),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline), hintText: 'email'),
                ),
                const TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline), hintText: 'password'),
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  margin: const EdgeInsets.only(right: 40),
                  width: double.infinity,
                  child: const Text(
                    'Continuar',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 300,
          //   right: 100,
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       padding: const EdgeInsets.only(bottom: 6, right: 100),
          //       margin: const EdgeInsets.all(40),
          //       width: double.infinity,
          //       child: const Text('Continuar'),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
