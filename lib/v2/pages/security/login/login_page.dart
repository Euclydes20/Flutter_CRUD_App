import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool withSafeArea = false;

  @override
  Widget build(BuildContext context) {
    if (withSafeArea) {
      return SafeArea(
        child: page(),
      );
    }
    return page();
  }

  Widget page() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade900, Colors.green.shade900],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              textTitle(),
              const SizedBox(height: 50),
              icon(),
              const SizedBox(height: 50),
              input(
                controller: usernameController,
                icon: Icons.person,
                hintText: "Username",
              ),
              const SizedBox(height: 10),
              input(
                controller: passwordController,
                icon: Icons.lock,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 10),
              textForgotPassword("Forgot Password?"),
              const SizedBox(height: 50),
              button(),
              const SizedBox(height: 50),
              textRegister()
            ],
          ),
        ),
      ),
    );
  }

  Widget textTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "BASIC CRUD APP BY EUCLYDES",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Widget icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 120,
      ),
    );
  }

  Widget input({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(icon, size: 25),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }

  Widget textForgotPassword(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              print("Forgot Password Clicked!");
            },
            child: const Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blue.shade600),
          overlayColor: const MaterialStatePropertyAll(Colors.blue),
          minimumSize: const MaterialStatePropertyAll(
            Size(double.infinity, 50),
          ),
        ),
        child: const Text(
          "Access",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget textRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            print("Register Now Clicked!");
          },
          child: const Text(
            "Register now.",
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
      ],
    );
  }
}
