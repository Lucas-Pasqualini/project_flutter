import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:projet_flutter/screen/sign_up/web/sign_up_web.dart';

import 'mobile/sign_up_mobile.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Scaffold(
        body: SignUpWeb(),
      );
    } else {
      return const Scaffold(
        body: SafeArea(child: SignUpMobile()),
      );
    }
  }
}
