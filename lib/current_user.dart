
import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
final db = FirebaseFirestore.instance;

class GetUser {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static String? get(){

    final User? user =  auth.currentUser;
    String? email  = user?.email;

    return email;
  }



}






class Users extends GetUser {

  String fname = '';
  late final data;
  Future<dynamic> getUserData(String x) async  {

    final docRef = db.collection("Users").doc(GetUser.get());

    data =  await docRef.get().then((DocumentSnapshot doc){

      return doc.data() as Map<String, dynamic>;

    });
    return data['Balance'];

    }

  Future<dynamic> getUserData2(String email) async  {

    final docRef = db.collection("Users").doc(email);

    data =  await docRef.get().then((DocumentSnapshot doc){

      return doc.data() as Map<String, dynamic>;

    });
    return data['Balance'];

  }


  }






