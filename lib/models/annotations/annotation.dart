import 'package:crud_app/models/users/user.dart';

class Annotation {
  final int id;
  final String title;
  final String text;
  final DateTime? creationDate;
  final DateTime? lastChange;
  final int? userId;
  final User? user;

  Annotation({
    required this.id,
    required this.title,
    required this.text,
    this.creationDate,
    this.lastChange,
    this.userId,
    this.user,
  });

  factory Annotation.fromJson(Map<String, dynamic> json) {
    return Annotation(
      id: json["Id"],
      title: json["Title"],
      text: json["Text"],
      creationDate: json["CreationDate"] != null
          ? DateTime.parse(json["CreationDate"])
          : null,
      lastChange: json["LastChange"] != null
          ? DateTime.parse(json["LastChange"])
          : null,
      userId: json["UserId"],
      user: json["User"] != null ? User.fromJson(json["User"]) : null,
    );
  }
}
