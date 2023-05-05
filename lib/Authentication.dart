


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';




class Authentication{

  final user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _firebaseAuth;
  Authentication(this._firebaseAuth);

  Stream<User?> get authStateChanges =>_firebaseAuth.authStateChanges();
  Future<String?> SignOut({required BuildContext context}) async{
    await _firebaseAuth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }
  Future<void> signIn({required String email,required String pass,required BuildContext context}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);


      if (FirebaseAuth.instance.currentUser != null) {

        print(user?.uid);
        print("correct user id");


      }

    }
    on FirebaseAuthException catch(e){
      print("wrong credentials");



    }
  }

  Future<String?> signUp({required String email,required String pass}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      return "Signed in";
    }
    on FirebaseAuthException catch(e){
      return e.message;
    }
  }
}

