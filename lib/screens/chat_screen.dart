import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(8),
          child: Text("This works!"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/Jfgpt516ksG9WAwtw2q6/messages")
              .snapshots()
              .listen((data) {
            data.docs.forEach((document) {
              print(document['text']);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
