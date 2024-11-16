import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;

  UserModel? get user => _user;
  bool get isAuthenticated => _auth.currentUser != null;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
      );

      await _firestore.collection('users').doc(user.id).set(user.toJson());
      _user = user;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await _firestore.collection('users').doc(credential.user!.uid).get();
      _user = UserModel.fromJson(doc.data()!..['id'] = doc.id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> loadUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final doc = await _firestore.collection('users').doc(currentUser.uid).get();
      _user = UserModel.fromJson(doc.data()!..['id'] = doc.id);
      notifyListeners();
    }
  }
}