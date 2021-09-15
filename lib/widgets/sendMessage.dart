import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessage extends StatelessWidget {
  final uid;
  SendMessage({required this.uid});
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
          style: ElevatedButton.styleFrom(primary: Color(0xffFCD34D)),
          onPressed: () {
            if(_controller.text.isEmpty) return;
            FirebaseFirestore.instance
                .collection('chats')
                .add({'text':_controller.text.toString(),'user': uid});
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
