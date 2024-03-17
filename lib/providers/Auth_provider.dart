import 'package:chat_app/models/routes.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../models/chat_user.dart';

class Authprovider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;
  late ChatUser user;
  Authprovider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    // _auth.signOut();
    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then((_snapshot) {
          print("testing user function");
          Map<String, dynamic> _userData =
              _snapshot.data()! as Map<String, dynamic>;
          user = ChatUser.fromJson({
            "name": _userData["name"],
            // "uid": _userData["uid"],
            "email": _userData["email"],
            "image": _userData["image"],
            "lastActive": _userData["lastActive"],
          });
          print("clicked but not working");
        }); //temporary for running the code issue is the function is running but not completing the function error some requested docs not found
        Get.toNamed(AppRoutes.home);
        // _navigationService.navigateTo('/login');
      } else {
        Get.toNamed(AppRoutes.login);
        print("User is  logged o");
        // _navigationService.navigateTo('/home');
      }
    });
  }

  Future<void> login(String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      print(_auth.currentUser);
      // _navigationService.navigateTo('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String?> registerUser(String _email, String _password) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return _credentials.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
