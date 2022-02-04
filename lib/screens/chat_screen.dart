import 'package:cloud_firestore/cloud_firestore.dart';
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
            onChanged: null)
      ]),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/aVcSH0jFv2L4mMib9Oh6/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(docs[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/aVcSH0jFv2L4mMib9Oh6/messages')
              .add({'text': 'bottom text'});
        },
      ),
    ); // Scaffold
  }
}
