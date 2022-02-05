import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        return ListView.builder(
          reverse: true,
          itemCount: 10,
          itemBuilder: (ctx, index) => Container(
            padding: const EdgeInsets.all(8),
            child: Text(docs[index]['text']),
          ),
        );
      },
    );
  }
}
