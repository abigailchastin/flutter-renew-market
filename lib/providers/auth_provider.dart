import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  AuthenticationProvider() {
    loadUser();
  }

  void loadUser() {
    _user = _auth.currentUser;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      loadUser();
      return true;
    } catch (e) {
      print('Sign-in error: $e');
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String name, String nickname) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await createUserDocument(userCredential.user!, name, nickname);
      loadUser();
      return true;
    } catch (e) {
      print('Sign-up error: $e');
      return false;
    }
  }

  Future<void> createUserDocument(User user, String name, String nickname) async {
    final userDoc = {
      'email': user.email,
      'name': name,
      'nickname': nickname,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userDoc);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    loadUser();
    print('User signed out.');
  }
}
