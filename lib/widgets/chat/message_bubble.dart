import 'package:chat_app_firebase/utils/constant.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble(
    this.message,
    this.isMe, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: radius,
              topRight: radius,
              bottomLeft: !isMe ? const Radius.circular(0) : radius,
              bottomRight: isMe ? const Radius.circular(0) : radius,
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe
                  ? Colors.black
                  : Theme.of(context).primaryTextTheme.headline1!.color,
            ),
          ),
        ),
      ],
    );
  }
}
