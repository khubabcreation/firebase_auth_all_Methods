import 'package:fire_auth_prac/Screens/PhoneNumber_Screen.dart';
import 'package:fire_auth_prac/Screens/SighnUp_Screen.dart';
import 'package:fire_auth_prac/Screens/Successed.dart';
import 'package:fire_auth_prac/Splash_Services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    auth
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Successfull(),
          ));
    }).onError((error, stackTrace) {
      utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('log in'),
        ),
        body: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: emailController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: '*Required'),
                      EmailValidator(errorText: 'Invalid Email'),
                    ]),
                    decoration: InputDecoration(
                        label: Icon(Icons.person),
                        hintText: 'Enter your Email')),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: passwordController,
                  validator: RequiredValidator(errorText: '*Required'),
                  decoration: InputDecoration(
                      label: Icon(Icons.lock),
                      hintText: 'Enter your Password')),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Text('Submitted')),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('if You have no Account ?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SighnUpScreen(),
                          ));
                    },
                    child: Text('Sighn Up')),
                SizedBox(
                  height: 10,
                ),
              ]),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhoneNumber(),));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('log in with Phone Number'),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
