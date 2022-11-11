import 'package:fire_auth_prac/Screens/Add_Post_Screen.dart';
import 'package:fire_auth_prac/Screens/Login_Screens.dart';
import 'package:fire_auth_prac/Splash_Services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Successfull extends StatefulWidget {
  const Successfull({Key? key}) : super(key: key);

  @override
  State<Successfull> createState() => _SuccessfullState();
}

class _SuccessfullState extends State<Successfull> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Google');
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('success'),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  }).onError((error, stackTrace) {
                    utils().toastMessage(error.toString());
                  });
                },
                icon: Icon(Icons.insights_outlined))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                onChanged: (String value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0))),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title =
                        snapshot.child('Post_Of_User').value.toString();
                    if (searchController.text.isEmpty) {
                      return ListTile(
                        title: Text(
                            snapshot.child('Post_Of_User').value.toString()),
                      );
                    } else if (title.toLowerCase().contains(
                    searchController.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(
                            snapshot.child('Post_Of_User').value.toString()),
                      );
                    } else {
                      Container(
                        child: Text('Invalid Input Please try again latter'),
                      );
                    }

                    return ListTile(
                      title:
                          Text(snapshot.child('Post_Of_User').value.toString()),
                    );
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(),
                ));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
