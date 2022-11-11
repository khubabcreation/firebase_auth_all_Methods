import 'dart:async';

import 'package:fire_auth_prac/Screens/Login_Screens.dart';
import 'package:fire_auth_prac/Screens/Successed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class firebaseServices {
  void islogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
        Duration(seconds: 2),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Successfull(),
            )),
      );
    } else {
      Timer(
        Duration(seconds: 2),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )),
      );
    }
  }
}
