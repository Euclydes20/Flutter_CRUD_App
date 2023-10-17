library;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveStringToLocalStorage(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> getStringFromLocalStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

Future<bool> removeKeyFromLocalStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.remove(key);
}

Future<void> showQuestionDialog(
  context, {
  required String title,
  required String text,
  IconData titleIcon = Icons.question_answer,
  String confirmText = "Yes",
  String cancelText = "No",
  Function()? onConfirmPress,
  Function()? onCancelPress,
}) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(titleIcon),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(title),
              ),
            ],
          ),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: onConfirmPress,
              child: Text(confirmText),
            ),
            TextButton(
              onPressed: onCancelPress,
              child: Text(cancelText),
            ),
          ],
        );
      });
}

Future<void> showInformationDialog(
  context, {
  required String title,
  required String text,
  IconData titleIcon = Icons.info,
  String confirmText = "Yes",
  Function()? onConfirmPress,
}) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(titleIcon),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(title),
              ),
            ],
          ),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: onConfirmPress,
              child: Text(confirmText),
            ),
          ],
        );
      });
}
