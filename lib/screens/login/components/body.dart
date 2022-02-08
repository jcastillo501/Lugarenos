import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lugarenos/screens/login/components/background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController PasswordController = TextEditingController();

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ;

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
          Positioned(
              top: screenHeight * 0.40,
              right: screenWidth * 0.25,
              child: Text('Ingresa con tu email y contraseña')),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.056),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: const TextField(
                    decoration: InputDecoration(
                        icon: Icon(
                      Icons.email,
                    )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.056),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: TextField(
                    controller: PasswordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key_outlined),
                    ),
                  ),
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
        ],
      ),
    );
  }

  Future sigIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.toString(),
        password: PasswordController.toString());
  }
}
