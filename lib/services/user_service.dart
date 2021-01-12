import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sparing/models/user.dart';

class UserServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signInWithEmail(Users user) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  //check if first time login
  Future<bool> isFirstTime(Users user) {
    return _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((data) => data.exists);
  }

  //sign up new account
  Future<void> signUpWithEmail(Users user) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  //check if login
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  //geti uid
  Future<String> getUser() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser.uid;
  }
}
