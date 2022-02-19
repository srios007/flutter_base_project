import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/services/firebase_service.dart';
import 'package:flutter_base_project/app/tools/paths.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_base_project/app/models/user.dart' as model;

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  ///signIn
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "";
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return e.code;
    }
  }

  ///signUp can be UserCredential or error string code
  Future<dynamic> signUp(
      {required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return e.code;
    }
  }

  ///sendPasswordReset
  Future<String> sendPasswordReset(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "success";
    } catch (err) {
      debugPrint(err.toString());
      return "error";
    }
  }

  ///Change password
  Future<String> changePassword(
    String currentPassword,
    String email,
    String newPassword,
  ) async {
    try {
      var _signInStatus = await signIn(email: email, password: currentPassword);
      if (_signInStatus.isEmpty) {
        var user = _firebaseAuth.currentUser;

        await user!.updatePassword(newPassword);

        return "success";
      } else {
        return "error";
      }
    } catch (err) {
      debugPrint(err.toString());
      return "error";
    }
  }

  ///Signin with google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final AuthCredential _credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );
      return await _firebaseAuth.signInWithCredential(_credential);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  ///Signin with Facebook
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult _result = await FacebookAuth.instance.login();
      if (_result.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential _credential =
            FacebookAuthProvider.credential(_result.accessToken!.token);
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(_credential);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  ///SignOut
  Future<bool> signOut(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<dynamic> perfomSignInWithGoogle() async {
    try {
      var _userCredential = await auth.signInWithGoogle();

      if (_userCredential == null) {
        return "Se ha cancelado la operación";
      }

      return _userCredential;
    } on Exception catch (e) {
      if (e.toString().contains('popup_closed_by_user')) {
        return "Se ha cancelado el inicio con Google";
      }
      return "Lo sentimos ha ocurrido un error desconocido";
    }
  }

  Future<dynamic> perfomSignInWithFacebook() async {
    try {
      var _userCredential = await auth.signInWithFacebook();

      if (_userCredential == null) {
        return "Se ha cancelado el inicio con Facebook";
      }

      return _userCredential;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return "Lo sentimos ha ocurrido un error desconocido";
    }
  }

  ///Get Currentuser
  User? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<model.User?> getCurrentUserObject() async {
    try {
      String _uid = getCurrentUser()!.uid;

      QuerySnapshot query = await database.getCollection(
        paths.usersCollection,
        'uid',
        _uid,
      );

      model.User? _user;
      if (query.docs.isNotEmpty) {
        _user = model.User.fromJson(
            query.docs.first.data() as Map<String, dynamic>);
      }

      return _user;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("Probablemente el usuario no ha iniciado sesion...");
      return null;
    }
  }
}

final AuthService auth = AuthService(FirebaseAuth.instance);
