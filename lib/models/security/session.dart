class Session {
  static int userId = 0;
  static String userName = "";
  static String userLogin = "";
  static bool userSuper = false;
  static bool provisoryPassword = false;
  static String token = "";
  static DateTime expires = DateTime.now();

  Session({
    required int userId,
    required String userName,
    required String userLogin,
    required bool userSuper,
    required bool provisoryPassword,
    required String token,
    required DateTime expires,
  }) {
    Session.userId = userId;
    Session.userName = userName;
    Session.userLogin = userLogin;
    Session.userSuper = userSuper;
    Session.provisoryPassword = provisoryPassword;
    Session.token = token;
    Session.expires = expires;
  }

  /*factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      userId: json["UserId"],
      userName: json["UserName"],
      userLogin: json["UserLogin"],
      userSuper: json["UserSuper"],
      provisoryPassword: json["ProvisoryPassword"],
      token: json["Token"],
      expires: DateTime.parse(json["Expires"]),
    );
  }*/

  static Map<String, dynamic> getSession() {
    return <String, dynamic>{
      "userId": Session.userId,
      "userName": Session.userName,
      "userLogin": Session.userLogin,
      "userSuper": Session.userSuper,
      "provisoryPassword": Session.provisoryPassword,
      "token": Session.token,
      "expires": Session.expires,
    };
  }

  static void registerSession(Map<String, dynamic> json) {
    Session(
      userId: json["UserId"],
      userName: json["UserName"],
      userLogin: json["UserLogin"],
      userSuper: json["UserSuper"],
      provisoryPassword: json["ProvisoryPassword"],
      token: json["Token"],
      expires: DateTime.parse(json["Expires"]),
    );
  }

  static void destroySession() {
    Session.userId = 0;
    Session.userName = "";
    Session.userLogin = "";
    Session.userSuper = false;
    Session.provisoryPassword = false;
    Session.token = "";
    Session.expires = DateTime.now();
  }

  static bool isValid() {
    return userId > 0 &&
        userName.isNotEmpty &&
        userLogin.isNotEmpty &&
        token.isNotEmpty &&
        expires.compareTo(DateTime.now()) > 0;
  }
}
