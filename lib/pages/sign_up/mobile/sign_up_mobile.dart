import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:projet_flutter/pages/sign_in/sign_in.dart';
import '../sign_up_form.dart';

class SignUpMobile extends StatelessWidget {
  const SignUpMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/noir.png',
                  height: height * 0.35, fit: BoxFit.fill),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 19.0),
                child: Text(
                  "Create\nan account",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50
                  ),
                ),
              ),
              const SignUpForm(heightArg: 0.08, widthArg: 0.85, padding: 5,),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: width * 0.5,
                child: const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
                child: TextButton(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: HexColor('#BEBBC9'))),
                          const TextSpan(
                              text: 'Sign in',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignIn()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
