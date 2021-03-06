import 'dart:io';

import 'package:chat_app/widgets/auth/userImagePicker.dart';
import 'package:flutter/material.dart';

class authForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      File userImageFile, bool islogin, BuildContext ctx) submitAuthForm;
  // final void Function(String email, String password, String username,
  //     bool islogin, BuildContext ctx) submitAuthForm;
  final bool isLoading;
  const authForm(this.submitAuthForm, this.isLoading);

  @override
  _authFormState createState() => _authFormState();
}

class _authFormState extends State<authForm> {
  final formkey = GlobalKey<FormState>();
  bool islogin = true;
  String email = '';
  String password = '';
  String username = '';
  late File userImageFile = File('');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              if (!islogin) UserImagePicker(pickedimage),

              TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  key: const ValueKey('email'),
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (val) => email = val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(labelText: 'Email Address')),

              // TextForefield
              if (!islogin) // TextFormField
                TextFormField(
                  autocorrect: true,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.words,
                  key: const ValueKey('username'),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 4) {
                      return 'Please enter a username with mor than 3 letters';
                    }
                    return null;
                  },
                  onSaved: (val) => username = val!,
                  decoration:
                      const InputDecoration(labelText: 'Username Address'),
                ),
              TextFormField(
                key: const ValueKey('password'),
                validator: (val) {
                  if (val!.isEmpty || val.length < 7) {
                    return 'Please enter a password with more than 8 letters';
                  }
                  return null;
                },
                onSaved: (val) => password = val!,
                decoration:
                    const InputDecoration(labelText: 'password Address'),
                obscureText: true,
              ), // TextFormfield
              const SizedBox(height: 12),
              if (widget.isLoading) const CircularProgressIndicator(),
              if (!widget.isLoading)
                ElevatedButton(
                  child: Text(islogin ? 'Login' : 'Signup'),
                  onPressed: submit,
                ), // RaisedButton
              if (!widget.isLoading)
                TextButton(
                    child: Text(
                        islogin
                            ? 'create new account'
                            : 'I already have account',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    onPressed: () {
                      setState(() {
                        islogin = !islogin;
                      });
                    }),
            ]),
          ), // Forn
        ), // singleChildscrollview
      ), // Card
    ); // Center;
  }

  void pickedimage(File pickedImage) {
    userImageFile = pickedImage;
  }

  void submit() {
    final isvalid = formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!islogin && userImageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: const Text('please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      // return;
    }
    if (isvalid) {
      formkey.currentState?.save();
      print('email $email');
      print('password $password');
      print('username $username');

      widget.submitAuthForm(email.trim(), password, username.trim(),
          userImageFile, islogin, context);
      // widget.submitAuthForm(
      //     email.trim(), password, username.trim(), islogin, context);
    }
  }
}
