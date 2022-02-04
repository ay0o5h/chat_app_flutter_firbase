import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
