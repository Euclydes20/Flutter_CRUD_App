import 'package:crud_app/v1/screens/security/login/login.dart' as v1;
import 'package:crud_app/v2/pages/security/login/login_page.dart' as v2;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> bodyVersion = {
      "v1": v1.LoginPage(
        key: Key("/${const v1.LoginPage().runtimeType.toString()}"),
      ),
      "v2": const v2.LoginPage(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: Scaffold(
        //Session.isValid() ? const HomePage() : const LoginPage()
        body: bodyVersion["v1"],
      ),
    );
  }
}
