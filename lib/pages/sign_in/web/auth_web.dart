import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projet_flutter/pages/got_api/mobile/list_got_api_mobile.dart';
import 'package:projet_flutter/pages/got_api/web/list_got_api_web.dart';
import 'package:projet_flutter/data/providers/remote/authentication_firebase.dart';
import 'package:projet_flutter/pages/sign_in/test_widget.dart';

class AuthWeb extends StatelessWidget {
  const AuthWeb({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FlutterLogin(
      title: 'GOT Quiz Game',
      logo: AssetImage('assets/images/trone.png'),
      onLogin: AuthenticationHelper().signIn,
      onSignup: AuthenticationHelper().signUp,
      onSubmitAnimationCompleted: () {
        if (kIsWeb) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ListGotApiWeb()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ListGotApiMobile()));
        }
      },
      onRecoverPassword: AuthenticationHelper().recoverPassword,
    );
  }
}
