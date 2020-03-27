import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_brew_crew/model/user.dart';
import 'package:flutter_brew_crew/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = authResult.user;

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // register with email and pw
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: firebaseUser.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // signin with email & pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Error Signing out $e');
      return null;
    }
  }
}
