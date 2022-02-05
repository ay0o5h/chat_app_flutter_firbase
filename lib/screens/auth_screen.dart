import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authScreen extends StatefulWidget {
  const authScreen({Key? key}) : super(key: key);

  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: authForm(submitAuthForm, isLoading),
    );
  }

  Future<void> submitAuthForm(String email, String password, String username,
      bool islogin, BuildContext ctx) async {
    UserCredential _authResult;

    try {
      setState(() {
        isLoading = true;
      });
      if (islogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authResult.user!.uid)
            .set({'username': username, 'password': password});
      }
    } on FirebaseAuthException catch (e) {
      String nessage = 'error Occerd';
      if (e.code == 'weak-password') {
        nessage = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        nessage = 'The account already exists for that enail.';
      } else if (e.code == 'user-not-found') {
        nessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        nessage = 'Wrong password provided for that user. ';
      }
      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(nessage),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }
}
