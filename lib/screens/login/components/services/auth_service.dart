import 'package:firebase_auth/firebase_auth.dart';
import 'package:lugarenos/screens/login/components/userModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebase(User user) {
    return UserModel(
        userId: user.uid, email: user.email, name: user.displayName);
  }

//registrarse
  Future signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = cred.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> checkIfEmailInUse(String email) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return true;
    }
  }

//iniciar
  Future signinUsingEmailPassword(String email, String pass) async {
    try {
      UserCredential cred =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = cred.user;
      return _userFromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

//salir
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
