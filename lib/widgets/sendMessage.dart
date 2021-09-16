import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessage extends StatelessWidget {
  final uid;
  final username;
  final Function scroll;

  SendMessage(
      {required this.uid, required this.username, required this.scroll});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter message",
            ),
            onChanged: (value) {},
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.amber),
          onPressed: () async {
            if (_controller.text.isEmpty) return;
            await FirebaseFirestore.instance.collection('chats').add({
              'text': _controller.text.toString(),
              'user': uid,
              'username': username,
              'createdAt': Timestamp.now(),
            });
            _controller.clear();
            scroll();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 17),
            child: Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
