import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class new_messages extends StatefulWidget {
  const new_messages({Key? key}) : super(key: key);

  @override
  _new_messagesState createState() => _new_messagesState();
}

class _new_messagesState extends State<new_messages> {
  final controller = TextEditingController();
  String enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            autocorrect: true,
            enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ), // UnderlineInputBorder
                hintText: 'Send a message...',
                hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
            onChanged: (val) {
              setState(() {
                enteredMessage = val;
              });
            },
          ),
        ),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: const Icon(Icons.send),
          onPressed: enteredMessage.trim().isEmpty ? null : _sendMessage,
        ),
      ]),
    ); // Container
  }

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'username': userData['username'],
      'userId': user.uid,
      'image_url': userData['image_url'],
    });
    controller.clear();
    setState(() {
      enteredMessage = '';
    });
  }
}
