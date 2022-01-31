import 'package:flutter/material.dart';
import 'package:projet_flutter/data/providers/remote/authentication_firebase.dart';
import 'package:projet_flutter/pages/sign_in/web/auth_web.dart';


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: Center(
        child: FlatButton(
          child: Text("Button here"),
          onPressed: () {
            AuthenticationHelper().signOut();
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AuthWeb()));}
    ))
    );
  }
}