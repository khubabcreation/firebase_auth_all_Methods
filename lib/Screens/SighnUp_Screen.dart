import 'package:fire_auth_prac/Screens/Login_Screens.dart';
import 'package:fire_auth_prac/Splash_Services/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SighnUpScreen extends StatefulWidget {
  const SighnUpScreen({Key? key}) : super(key: key);

  @override
  State<SighnUpScreen> createState() => _SighnUpScreenState();
}

class _SighnUpScreenState extends State<SighnUpScreen> {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sighn Up'),
      ),
      body: Form(
        key: key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              validator: RequiredValidator(errorText: 'Required'),
              decoration:
                  InputDecoration(label: Icon(Icons.person), hintText: 'Email'),
            ),
            TextFormField(
              controller: passController,
              validator: RequiredValidator(errorText: 'Required '),
              decoration: InputDecoration(
                  label: Icon(Icons.lock), hintText: 'Password'),
            ),
            TextFormField(
              controller: confirmPasswordController,
              validator: RequiredValidator(errorText: 'Required'),
              decoration: InputDecoration(
                  label: Icon(Icons.lock_clock), hintText: 'Confirm Password'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    // try {
                    //   UserCredential cred = await auth
                    //       .createUserWithEmailAndPassword(
                    //       email: emailController.text,
                    //       password: passController.text);
                    //
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => LoginScreen(),
                    //       ));
                    // }
                    //
                    // catch (e) {
                    //     print(object)
                    // }
                    auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text).then((value){
                    Navigator.of(context).pop();
                    }).onError((error, stackTrace){
                       utils().toastMessage(error.toString());
                    });
                  }
                },
                child: Text('Create Account'))
          ],
        ),
      ),
    );
  }
}
