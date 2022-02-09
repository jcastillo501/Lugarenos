import 'package:flutter/material.dart';
import 'package:lugarenos/screens/login/components/services/auth_service.dart';
import 'package:lugarenos/screens/signUp/components/background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _errors = "";
  String _nameVal = "";
  String _emailVal = "";
  String _adrresVal = "";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Background(
        child: Stack(
      children: <Widget>[
        Positioned(
            top: screenHeight * 0.25,
            right: screenWidth * 0.25,
            child: Image.asset(
              "assets/images/fondo.png",
              height: screenHeight * 0.05,
            )),
        Positioned(
          top: screenHeight * 0.33,
          right: screenWidth * 0.13,
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.1),
            child: const Text('Completa los siguientes campos para continuar'),
          ),
        ),
        Container(
          child: Form(
            key: _formKey,
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.056,
                      vertical: screenHeight * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _nameVal = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'ingrese un nombre';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.056,
                      vertical: screenHeight * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.vpn_key),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _adrresVal = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'ingrese una direccion';
                        }
                        return null;
                      }),
                ),
                Container(
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.07,
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFFDFDFDF)),
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loader();
                        });
                      }
                    },
                    child: const Text(
                      ' Continuar',
                      style: TextStyle(
                          color: Color(0xFF033236),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )),
          ),
        )
      ],
    ));
  }

  Future loader() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
