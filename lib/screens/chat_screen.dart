import 'package:chat_app/widgets/messages/message.dart';
import 'package:chat_app/widgets/messages/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat'), actions: [
        DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ), // Icon
            items: [
              DropdownMenuItem(
                  child: Row(children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ]),
                  value: 'logout'),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            }),
      ]),
      body: Container(
          child: Column(children: const [
        Expanded(child: message()),
        new_messages(),
      ])),
    ); // Scaffold
  }
}
