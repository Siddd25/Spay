

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:s_pay/current_user.dart';




class add_conn{

  int amount =0;
  int balance=0;


  add_conn();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');


  Future <void> debit(double y,String acc) async {


    dynamic bal1=  await getdata() as dynamic;
    dynamic bal2 = await getdata2(acc) as dynamic;

    dynamic res = await bal1 - y ;
    dynamic res2 = await bal2+y;
    if(bal1<y){
      print("Insufficient Balance");
    }
    else {
      double re = res as double;

       await users
          .doc(GetUser.get())
          .update({'Balance':re}).then((value) => print("Value updated"))
          .catchError((error)=>print("Error"));

       await users
          .doc(acc)
          .update({'Balance':res2}).then((value) => print("Value updated"))
          .catchError((error)=>print("Error"));


    }
    }





  Future <void> credit(dynamic y)  async {
    dynamic bal=  await getdata() as dynamic;

    dynamic res = await bal + y ;
    double re =  res as double;
    print(re);
    return users
        .doc(GetUser.get())
        .update({'Balance':re}).then((value) => print("Value updated"))
        .catchError((error)=>print("Error"));


  }


}
Future<dynamic> getdata() async {
  //await Future.delayed(Duration(seconds: 4));
  Users u= Users();
  final balance = u.getUserData('bal');

  return balance;
}
Future<dynamic> getdata2(String email) async {
  //await Future.delayed(Duration(seconds: 4));
  Users u= Users();
  final balance = u.getUserData(email);

  return balance;
}
