import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/message_bubble.dart';


class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(                     // so we .orderBy('createdAt', descending: true) order according to the time stamp in decending order because we want to show the data in chat form
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.documents;
        return ListView.builder(
          reverse: true, // it will scroll from bottom to the top
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text']
          ),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}