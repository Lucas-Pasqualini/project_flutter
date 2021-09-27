import 'package:flutter/material.dart';
import 'package:projet_flutter/screen/got/list.dart';
// import 'package:projet_flutter/screen/sign_in/sign_in.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const SignIn(),
      home: const ListScreen(),
    );
  }
}
