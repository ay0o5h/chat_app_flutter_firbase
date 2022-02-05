import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBIVRA4AvntMiKP5O91KxrzrQlys2zF7HY",
      appId: "1:178290825349:android:9a386bb773823c29e2b1ec",
      messagingSenderId: "AIzaSyBIVRA4AvntMiKP5O91KxrzrQlys2zF7HY",
      projectId: "chatapp-3f6d7",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
              primaryColor: Colors.pink,
              backgroundColor: Colors.pink,
              buttonTheme: ButtonTheme.of(context),
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: Colors.deepPurple))
          .copyWith(
              // textTheme: ButtonTextTheme.primary,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
              ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            if (snapShot.hasData) {
              return ChatScreen();
            } else {
              return const authScreen();
            }
          }), // StreanBuilder
    ); // MaterialApp
  }
}
