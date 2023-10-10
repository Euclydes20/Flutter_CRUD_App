import 'dart:convert';

import 'package:crud_app/models/configuration/configuration.dart';
import 'package:crud_app/models/response_model.dart';
import 'package:http/http.dart' as http;

class ConfigurationService {
  static Map<String, String> getHeaders() {
    return {
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
    };
  }

  static String url = "";

  static Future<ResponseModel<String>> getBaseUrl() async {
    var responseInfo = ResponseModel<String>();

    try {
      final response = await http
          .get(
            Uri.parse(Configuration.baseUrlStorage),
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
        responseInfo.data = jsonDecoded["body"];
        if (responseInfo.data == null || responseInfo.data!.isEmpty) {
          responseInfo.success = false;
          responseInfo.message = "Fail: Server not Identified.";
        }
      } else {
        responseInfo.success = false;
      }
      responseInfo.message = responseInfo.message.isEmpty
          ? (responseInfo.success ? "Success: Server Identified." : "")
          : responseInfo.message;
    } catch (_) {
      responseInfo.success = false;
      responseInfo.message = "Fail: Connection error.";
    }

    return responseInfo;
  }
}
