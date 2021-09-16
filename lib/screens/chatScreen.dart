import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import '../widgets/sendMessage.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chatScreen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  final _controller = ScrollController();

  void scrollDown() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      () => _controller.animateTo(
        _controller.position.minScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final uid = args["uid"];
    final currentUser = args["username"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.logout),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: Text(
          "Chatroom",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshotData) {
              if (snapshotData.connectionState == ConnectionState.waiting)
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
              final documents = snapshotData.data!.docs;
              print(documents);

              return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: documents.length,
                  itemBuilder: (ctx, index) {
                    final message = documents[index]['text'];
                    final user = documents[index]['user'];
                    final username = documents[index]['username'];
                    return Column(
                      crossAxisAlignment: user == uid
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            child: Text(
                              username,
                              style: TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ),
                        ),
                        Container(
                          child: ChatBubble(
                            alignment: (user == uid)
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            backGroundColor: (user == uid)
                                ? Colors.black54
                                : Color(0xffE6AE06),
                            child: Text(
                              message,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            clipper: ChatBubbleClipper9(
                                nipSize: 5,
                                type: user == uid
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble),
                          ),
                        ),
                      ],
                    );
                  });
            },
          )),
          SendMessage(
            username: currentUser,
            uid: uid,
            scroll: scrollDown,
          )
        ],
      ),
    );
  }
}
