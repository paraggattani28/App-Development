import 'package:project3/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project3/screens/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project3/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String mobile,
      String address,
      String username,
      String imageLink,
      bool register) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(
          email, mobile, address, username, imageLink, register);

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future deleteUser(String email) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      AuthCredential credentials =
          EmailAuthProvider.getCredential(email: email);
      print(user);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user.uid)
          .deleteuser(); // called from database class
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
