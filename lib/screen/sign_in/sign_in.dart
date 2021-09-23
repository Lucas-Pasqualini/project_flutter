import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:projet_flutter/screen/sign_in/web/sign_in_web.dart';

import 'mobile/sign_in_mobile.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {

    if (kIsWeb) {
      return const Scaffold(
        body: SignInWeb(),
      );
    } else {
      return const Scaffold(
        body: SafeArea(child: SignInMobile()),
      );
    }
  }
}
