import 'package:fire_auth_prac/Splash_Services/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final postController = TextEditingController();
   final databaseref = FirebaseDatabase.instance.ref('Google');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height-kToolbarHeight;
    return
      SafeArea(
        child: Scaffold(

      body: Container(
        height: height,
        child: Column(

          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              decoration: InputDecoration(
                  labelText: 'Add items', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
               databaseref.child(DateTime.now().millisecond.toString()).set({
                 'id':DateTime.now().millisecond,
                 'Post_Of_User': postController.text,

               });
                },
                child: Text('Add')),
          ],
        ),
      ),
    ));
  }
}
