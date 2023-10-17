import 'dart:convert';

import 'package:crud_app/v1/models/configurations/configuration.dart';
import 'package:crud_app/v1/models/response_model.dart';
import 'package:crud_app/v1/models/security/session.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Map<String, String> getHeaders() {
    return {
      "Content-Type": "application/json",
    };
  }

  static String url = "v1/Authentication";

  static Future<ResponseModel<Map<String, dynamic>>> authenticate(
      Object login) async {
    var responseInfo = ResponseModel<Map<String, dynamic>>();

    try {
      final response = await http
          .post(
            Uri.parse("${Configuration.baseUrl}/$url/Authenticate"),
            body: jsonEncode(login),
            headers: getHeaders(),
          )
          .timeout(const Duration(seconds: 5));
      responseInfo.statusCode = response.statusCode;
      if (response.statusCode != 200 && response.body.isEmpty) {
        responseInfo.success = false;
        responseInfo.message = response.reasonPhrase ?? "Unknown error.";
        return responseInfo;
      }
      if (response.body.isNotEmpty) {
        final jsonDecoded = jsonDecode(response.body);
        responseInfo = ResponseModel.fromJson(jsonDecoded);
        if (jsonDecoded["Data"] is Map<String, dynamic>) {
          Session.registerSession(jsonDecoded["Data"]);
          responseInfo.data = Session.getSession();
        } else {
          responseInfo.success = false;
          responseInfo.message = responseInfo.message.isNotEmpty
              ? responseInfo.message
              : "Invalid login.";
          return responseInfo;
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: Authenticated." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }
}
