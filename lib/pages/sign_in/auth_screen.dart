import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:projet_flutter/pages/sign_in/web/auth_web.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Scaffold(
        body: AuthWeb(),
      );
    } else {
      return const Scaffold(
        body: SafeArea(child: AuthWeb()),
      );
    }
  }
}
