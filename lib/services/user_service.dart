import 'dart:convert';

import 'package:crud_app/models/configuration/configuration.dart';
import 'package:crud_app/models/response_model.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:crud_app/models/users/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Map<String, String> headers = {
    "authorization": "bearer ${Session.token}",
    "Content-Type": "application/json",
  };

  static String url = "v1/User";

  static Future<ResponseModel<User>> add(Object user) async {
    var responseInfo = ResponseModel<User>();

    try {
      final response = await http
          .post(
            Uri.parse("${Configuration.baseUrl}/$url"),
            body: jsonEncode(user),
            headers: headers,
          )
          .timeout(const Duration(seconds: 5));
      responseInfo.statusCode = response.statusCode;
      if (response.statusCode != 201 && response.body.isEmpty) {
        responseInfo.success = false;
        responseInfo.message = response.reasonPhrase ?? "Unknown error";
        return responseInfo;
      }
      if (response.body.isNotEmpty) {
        final jsonDecoded = jsonDecode(response.body);
        responseInfo = ResponseModel.fromJson(jsonDecoded);
        if (jsonDecoded["Data"] is Map<String, dynamic>) {
          responseInfo.data = User.fromJson(jsonDecoded["Data"]);
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: User added." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }

  static Future<ResponseModel<User>> update(Object user) async {
    var responseInfo = ResponseModel<User>();

    try {
      final response = await http
          .put(
            Uri.parse("${Configuration.baseUrl}/$url"),
            body: jsonEncode(user),
            headers: headers,
          )
          .timeout(const Duration(seconds: 5));
      responseInfo.statusCode = response.statusCode;
      if (response.statusCode != 200 && response.body.isEmpty) {
        responseInfo.success = false;
        responseInfo.message = response.reasonPhrase ?? "Unknown error";
        return responseInfo;
      }
      if (response.body.isNotEmpty) {
        final jsonDecoded = jsonDecode(response.body);
        responseInfo = ResponseModel.fromJson(jsonDecoded);
        if (jsonDecoded["Data"] is Map<String, dynamic>) {
          responseInfo.data = User.fromJson(jsonDecoded["Data"]);
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: User edited." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }

  static Future<ResponseModel<User>> delete(String userId) async {
    var responseInfo = ResponseModel<User>();

    try {
      final response = await http
          .delete(
            Uri.parse("${Configuration.baseUrl}/$url/$userId"),
            headers: headers,
          )
          .timeout(const Duration(seconds: 5));
      responseInfo.statusCode = response.statusCode;
      if (response.statusCode != 200 && response.body.isEmpty) {
        responseInfo.success = false;
        responseInfo.message = response.reasonPhrase ?? "Unknown error";
        return responseInfo;
      }
      if (response.body.isNotEmpty) {
        final jsonDecoded = jsonDecode(response.body);
        responseInfo = ResponseModel.fromJson(jsonDecoded);
        if (jsonDecoded["Data"] is Map<String, dynamic>) {
          responseInfo.data = User.fromJson(jsonDecoded["Data"]);
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: User deleted." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }

  static Future<ResponseModel<List<User>>> getAll() async {
    var responseInfo = ResponseModel<List<User>>();

    try {
      final response = await http
          .get(
            Uri.parse("${Configuration.baseUrl}/$url"),
            headers: headers,
          )
          .timeout(const Duration(seconds: 5));
      responseInfo.statusCode = response.statusCode;
      if (response.statusCode != 200 && response.body.isEmpty) {
        responseInfo.success = false;
        responseInfo.message = response.reasonPhrase ?? "Unknown error";
        return responseInfo;
      }

      responseInfo.statusCode = response.statusCode;
      if (response.statusCode != 200 && response.body.isEmpty) {
        responseInfo.success = false;
        responseInfo.message = response.reasonPhrase ?? "Unknown error";
        return responseInfo;
      }
      if (response.body.isNotEmpty) {
        final jsonDecoded = jsonDecode(response.body);
        responseInfo = ResponseModel.fromJson(jsonDecoded);
        if (jsonDecoded["Data"] is List) {
          responseInfo.data = (jsonDecoded["Data"] as List)
              .map((u) => User.fromJson(u))
              .toList();
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: Users list." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }
}
