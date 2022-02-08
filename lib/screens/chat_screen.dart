import 'package:chat_app/widgets/messages/message.dart';
import 'package:chat_app/widgets/messages/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // void initstate() {
  //   super.initState();
  //   final fbm = FirebaseMessaging.instance;
  //   fbm.requestPermission();
  // fbm.configure(
  //   onMessage: (msg) {
  //     print(msg);
  //     return;
  //   },
  //   anLaunch: (msg) {
  //     print(msg);
  //     return;
  //   },
  //   onResume: (msg) {
  //     print(msg);
  //     return;
  //   },
  // );
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     // RemoteNotification notification = message.notification;
  //     // showNotification(notification);
  //     print("onMessage: $message");

  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print("onMessageOpenedApp: $message");
  //   });

  //  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
  //     print("onBackgroundMessage: $message");
  //   });
  //   fbm.subscribeToTopic('chat');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(title: const Text('Chat'), actions: [
        DropdownButton(
            underline: Container(),
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
          color: Colors.white,
          // height: 500,
          child: Column(children: const [
            Expanded(child: message()),
            new_messages(),
          ])),
    ); // Scaffold
  }
}
