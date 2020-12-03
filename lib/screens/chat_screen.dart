import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: <Widget>[
          DropdownButton( // adding drop down button
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [ // dropdown items
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8), // for spacing
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ], 
            onChanged: (itemIdentifier) {
              if(itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut(); // so here we do the user sign out
              }
            },
          ),
        ],
      ),
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
            FirebaseFirestore.instance
            .collection('/chats/UgBA2FSnEAts1W2pkccO/messages')
            .add({
              'text': 'this is another message'
            });
        },
      ),
    );
  }
}
