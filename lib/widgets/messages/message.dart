import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class message extends StatelessWidget {
  const message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final docs = snapshot.data!.docs;
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: 10,
          itemBuilder: (ctx, index) => MessageBubble(
            docs[index]['text'],
            docs[index]['username'],
            docs[index]['image_url'],
            docs[index]['userId'] == user!.uid,
            key: ValueKey(docs[index]['userId']),
          ),
        );
      },
    );
  }
}
