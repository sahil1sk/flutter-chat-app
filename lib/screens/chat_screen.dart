import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder( // StreamBuilder is flutter feature which helps to stream the real time data
        stream: FirebaseFirestore.instance // so in stream we provide real time data if there is any change in data then builder method will revalute again
              .collection('/chats/UgBA2FSnEAts1W2pkccO/messages')
              .snapshots(), 
        builder: (ctx, streamSnapshot) { // streamSnapshot is the object get access to recieve data
          if(streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents; 
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
            
        },
      ),
    );
  }
}
