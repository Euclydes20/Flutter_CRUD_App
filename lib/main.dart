import 'package:crud_app/screens/security/login/login.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:flutter/material.dart';
import "package:crud_app/screens/users/user_list.dart";

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
        body: Session.isValid() ? const UserListPage() : const LoginPage(),
      ),
    );
  }
}
