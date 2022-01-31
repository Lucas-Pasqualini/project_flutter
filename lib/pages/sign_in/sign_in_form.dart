import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter/pages/got_api/mobile/list_got_api_mobile.dart';
import 'package:projet_flutter/pages/got_api/web/list_got_api_web.dart';
import 'package:projet_flutter/data/providers/remote/authentication_firebase.dart';
import 'package:projet_flutter/pages/got_game/web/got_api_web.dart';

class SignInForm extends StatefulWidget {
  const SignInForm(
      {Key? key,
      required this.heightArg,
      required this.widthArg,
      required this.padding})
      : super(key: key);

  final double heightArg;
  final double widthArg;
  final double padding;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Form(
        key: _formKey,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SizedBox(
              width: width * widget.widthArg,
              height: height * widget.heightArg,
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.trim() == "" || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: widget.padding, left: 30, right: 30),
            child: SizedBox(
              width: width * widget.widthArg,
              height: height * widget.heightArg,
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.trim() == "" || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                obscureText: showPassword,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(
                          showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black),
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    focusColor: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              height: height * (widget.heightArg - 0.04),
              width: width * (widget.widthArg - 0.1),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // await FirebaseAuth.instance.signInWithEmailAndPassword(
                      //     email: emailController.text,
                      //     password: passwordController.text);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const ListGotApi()));
                      AuthenticationHelper()
                          .signIn(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((result) {
                        if (result == null) {
                          if (kIsWeb) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GotApiWeb()));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ListGotApiMobile()));
                          }
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ));
                        }
                      });
                    }
                  }),
            ),
          ),
        ]));
  }
}
