import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) {
            return Text(
              chatDocs[index]['text'],
            );
          },
        );
      },
    );
  }
}
