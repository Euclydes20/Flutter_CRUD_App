import 'package:flutter/material.dart';

class Utilities {
  static Future<void> showQuestionDialog(
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
}
