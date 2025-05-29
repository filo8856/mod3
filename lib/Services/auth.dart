import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mod3/Models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Cus? _FromFB(User? user) {
    return user != null ? Cus(uid: user.uid) : null;
  }

  Stream<Cus?> get user {
    return _auth.authStateChanges().map((User? user) => _FromFB(user));
  }

  //Signout
  Future SO() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Register
Future regemail(String email,String pass)async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      User? user=result.user;
      return _FromFB(user);
    }
    catch(e)
  {
    print(e.toString());
    return null;
  }
}
}
