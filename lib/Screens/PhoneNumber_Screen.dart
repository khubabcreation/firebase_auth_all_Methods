import 'package:fire_auth_prac/Screens/Verify_phone.dart';
import 'package:fire_auth_prac/Splash_Services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  bool loading = false;
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
                            label: Text('Enter your phone'))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        auth.verifyPhoneNumber(
                            phoneNumber: phoneController.text,
                            verificationCompleted: (_) {},
                            verificationFailed: (e) {
                              utils().toastMessage(e.toString());
                            },
                            codeSent: (String verificationid, int? token) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VerifyPhoneNumber(data: verificationid),
                                  ));
                            },
                            codeAutoRetrievalTimeout: (e) {
                              utils().toastMessage(e.toString());
                            });
                      },
                      child: Text('Verifiyed'))
                ],
              )),
        ),
      ),
    );

  }
}
