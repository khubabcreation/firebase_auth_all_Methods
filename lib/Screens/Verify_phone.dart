import 'package:fire_auth_prac/Screens/Successed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Splash_Services/utils.dart';

class VerifyPhoneNumber extends StatefulWidget {
  var data;

  VerifyPhoneNumber({Key? key, required this.data}) : super(key: key);

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Screen'),
      ),
      body: Container(
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0)),
                            label: Text('6 digit Code'))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final credential = PhoneAuthProvider.credential(
                            verificationId: widget.data,
                            smsCode: phoneController.text.toString());

                        try {
                          await auth.signInWithCredential(credential);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Successfull(),
                              ));
                        } catch (e) {
                          utils().toastMessage(e.toString());
                        }
                      },
                      child: Text('Verifiy'))
                ],
              )),
        ),
      ),
    );
  }
}
