import 'package:chat_app_firebase/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = chatSnapshot.data!.docs;
        final user = FirebaseAuth.instance.currentUser;

        return chatDocs.isEmpty
            ? const Center(
                child: Text(
                  'start chatting...',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['userId'] == user!.uid,
                  chatDocs[index]['username'],
                  key: ValueKey(chatDocs[index].id),
                ),
              );
      },
    );
  }
}
