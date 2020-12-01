import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This workds'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/UgBA2FSnEAts1W2pkccO/messages')
              .snapshots() // this will listen changes carefully if any happen inside collections
              .listen((data) {
            print('Here is the data ${data.docs[0]['text']}');
          });
        },
      ),
    );
  }
}
