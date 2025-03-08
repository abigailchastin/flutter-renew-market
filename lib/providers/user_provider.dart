

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/datas/mock_post.dart';
import 'package:flutter_application/models/user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Inisialisasi FirebaseAuth
  UserModel _user = mockUser; // Pastikan mockUser memiliki userId yang valid
  UserModel get user => _user;

  String get userId => _user.userId; // Perbaikan: Menggunakan userId sesuai UserModel

  void addFavorite(String postId) {
    if (!_user.favorites.contains(postId)) {
      _user.favorites.add(postId);
      notifyListeners();
    }
  }

  void removeFavorite(String postId) {
    if (_user.favorites.contains(postId)) {
      _user.favorites.remove(postId);
      notifyListeners();
    }
  }

  Future<void> loadUser() async {
    final firebaseUser = _auth.currentUser; // Menggunakan _auth yang sudah dideklarasikan
    if (firebaseUser != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();
        if (doc.exists) {
          _user = UserModel.fromJson(doc.data()!);
          notifyListeners();
        } else {
          print('User document not found in Firestore.');
        }
      } catch (e) {
        print('Error loading user: $e');
      }
    } else {
      print('No user is currently logged in.');
    }
  }
}