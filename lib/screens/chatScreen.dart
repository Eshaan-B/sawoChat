import 'package:flutter/material.dart';
import '../widgets/sendMessage.dart';

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

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final uid = args["uid"];
    final username = args["username"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout),color: Colors.black,),
        ],
        backgroundColor: Colors.amber,
        title: Text(
          "Chatroom",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('chats').snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshotData) {
              if (snapshotData.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              final documents = snapshotData.data!.docs;
              print(documents);
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (ctx, index) {
                    final message = documents[index]['text'];
                    return Container(
                      child: Text(message),
                    );
                  });
            },
          )),
          SendMessage(
            uid: uid,
          )
        ],
      ),
    );
  }
}
