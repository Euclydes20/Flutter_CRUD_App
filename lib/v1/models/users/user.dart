class User {
  final int id;
  final String name;
  final String login;
  final String password;
  final String bibliography;
  final bool superUser;
  final bool provisoryPassword;
  final DateTime creationDate;
  final DateTime? lastLogin;
  final bool blocked;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.bibliography,
    required this.superUser,
    required this.provisoryPassword,
    required this.creationDate,
    this.lastLogin,
    required this.blocked,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["Id"],
      name: json["Name"],
      login: json["Login"],
      password: json["Password"] ?? "",
      bibliography: json["Bibliography"],
      superUser: json["Super"],
      provisoryPassword: json["ProvisoryPassword"],
      creationDate: DateTime.parse(json["CreationDate"]),
      lastLogin:
          json["LastLogin"] != null ? DateTime.parse(json["LastLogin"]) : null,
      blocked: json["Blocked"],
    );
  }
}
