import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lugarenos/screens/login/components/background.dart';
import 'package:lugarenos/screens/login/components/services/auth_service.dart';
import 'package:lugarenos/screens/signUp/components/signUp.dart';
import 'package:lugarenos/screens/views/viewMain.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

final AuthService _authService = AuthService();
final _formKey = GlobalKey<FormState>();
String _errors = '';
String emailVal = '';
String passwordVal = '';

class _BodyState extends State<Body> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    WidgetsFlutterBinding.ensureInitialized();

    return ListView(
      children: [
        Background(
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
                  top: screenHeight * 0.37,
                  right: screenWidth * 0.25,
                  child: const Text('Ingresa con tu email y contraseña')),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.03),
                margin: EdgeInsets.only(top: screenHeight * 0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.056,
                            vertical: screenHeight * 0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email,
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                emailVal = val;
                              });
                            },
                            validator: (val) {
                              if (val!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)) {
                                return 'ingresa un correo valido';
                              }
                              return null;
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.056,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.vpn_key_outlined),
                          ),
                          validator: (val) => val!.length < 6
                              ? 'ingrese una contraseña de mas de 6 caracteres'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              passwordVal = val;
                            });
                          },
                        ),
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
                              dynamic result = await _authService
                                  .checkIfEmailInUse(emailVal);
                              if (result == true) {
                                setState(() {
                                  _errors = "Sesion iniciada";
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(_errors)));
                                });

                                await _authService.signinUsingEmailPassword(
                                    emailVal, passwordVal);

                                var firebaseUser =
                                    FirebaseAuth.instance.currentUser;
                                DocumentSnapshot docUser = await db
                                    .collection('users')
                                    .doc(firebaseUser?.uid)
                                    .get();
                                if (docUser.exists) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const ViewMain()));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const SignUp()));
                                }
                              } else if (result == false) {
                                _errors = "Correo disponible";
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(_errors)));

                                await _authService.signUpWithEmailPassword(
                                    email: emailVal, password: passwordVal);
                                _errors = 'creado';
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(_errors),
                                ));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const SignUp()));
                              }
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
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: const Text(
                          'Tambien puedes',
                          style: TextStyle(
                              color: Color(0xFF033236),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.facebook,
                              size: 30,
                              color: Colors.blue,
                            ),
                            Text('   '),
                            Icon(
                              Icons.g_mobiledata_rounded,
                              size: 50,
                              color: Colors.red,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
