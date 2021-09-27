import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter/screen/got/list.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {Key? key,
      required this.heightArg,
      required this.widthArg,
      required this.padding})
      : super(key: key);

  final double heightArg;
  final double widthArg;
  final double padding;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordBool = true;
  bool confirmPasswordBool = true;
  String password = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            width: width * widget.widthArg,
            height: height * widget.heightArg,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.trim() == "" || value.isEmpty) {
                  return 'Please enter email';
                } else if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email';
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
          Padding(
            padding: EdgeInsets.all(widget.padding),
            child: SizedBox(
              height: height * widget.heightArg,
              width: width * widget.widthArg,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.trim() == "" || value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 7) {
                    return 'Please enter a password of at least 6 characters';
                  }
                  return null;
                },
                obscureText: passwordBool,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(
                          passwordBool
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black),
                      onTap: () {
                        setState(() {
                          passwordBool = !passwordBool;
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
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: SizedBox(
              height: height * widget.heightArg,
              width: width * widget.widthArg,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.trim() == "" || value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.compareTo(password) == -1) {
                    return "Passwords aren't identical";
                  }
                  return null;
                },
                obscureText: confirmPasswordBool,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(
                          confirmPasswordBool
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black),
                      onTap: () {
                        setState(() {
                          confirmPasswordBool = !confirmPasswordBool;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Confirm password',
                    labelStyle: const TextStyle(color: Colors.black),
                    focusColor: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SizedBox(
              width: width * (widget.widthArg - 0.1),
              height: height * (widget.heightArg - 0.04),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Processing Data'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ListScreen()));
                    }
                  }),
            ),
          ),
        ]));
  }
}
