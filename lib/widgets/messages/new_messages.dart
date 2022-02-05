import 'package:cloud_firestore/cloud_firestore.dart';
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
            controller: controller,
            decoration: const InputDecoration(labelText: 'Send a message...'),
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

  _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
    });
    controller.clear();
  }
}
