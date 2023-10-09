import 'package:crud_app/screens/home.dart';
import 'package:crud_app/screens/security/login/login.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: Scaffold(
        //Session.isValid() ? const HomePage() : const LoginPage()
        body: LoginPage(
          key: Key("/${const LoginPage().runtimeType.toString()}"),
        ),
      ),
    );
  }
}
