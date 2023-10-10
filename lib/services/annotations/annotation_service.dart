import 'dart:convert';

import 'package:crud_app/models/annotations/annotation.dart';
import 'package:crud_app/models/configuration/configuration.dart';
import 'package:crud_app/models/response_model.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:http/http.dart' as http;

class AnnotationService {
  static Map<String, String> getHeaders() {
    return {
      "authorization": "bearer ${Session.token}",
      "Content-Type": "application/json",
    };
  }

  static String url = "v1/Annotation";

  static Future<ResponseModel<Annotation>> add(Object annotation) async {
    var responseInfo = ResponseModel<Annotation>();

    try {
      final response = await http
          .post(
            Uri.parse("${Configuration.baseUrl}/$url"),
            body: jsonEncode(annotation),
            headers: getHeaders(),
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
          responseInfo.data = Annotation.fromJson(jsonDecoded["Data"]);
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: Annotation added." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }

  static Future<ResponseModel<Annotation>> update(Object annotation) async {
    var responseInfo = ResponseModel<Annotation>();

    try {
      final response = await http
          .put(
            Uri.parse("${Configuration.baseUrl}/$url"),
            body: jsonEncode(annotation),
            headers: getHeaders(),
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
          responseInfo.data = Annotation.fromJson(jsonDecoded["Data"]);
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: Annotation edited." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }

  static Future<ResponseModel<Annotation>> delete(String annotationId) async {
    var responseInfo = ResponseModel<Annotation>();

    try {
      final response = await http
          .delete(
            Uri.parse("${Configuration.baseUrl}/$url/$annotationId"),
            headers: getHeaders(),
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
          responseInfo.data = Annotation.fromJson(jsonDecoded["Data"]);
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: Annotation deleted." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }

  static Future<ResponseModel<List<Annotation>>> getAll() async {
    var responseInfo = ResponseModel<List<Annotation>>();

    try {
      final response = await http
          .get(
            Uri.parse("${Configuration.baseUrl}/$url"),
            headers: getHeaders(),
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
              .map((a) => Annotation.fromJson(a))
              .toList();
        }
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: Annotations list." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }
}
