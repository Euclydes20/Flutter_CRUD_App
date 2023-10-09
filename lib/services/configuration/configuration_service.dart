import 'dart:convert';

import 'package:crud_app/models/configuration/configuration.dart';
import 'package:crud_app/models/response_model.dart';
import 'package:http/http.dart' as http;

class ConfigurationService {
  static Map<String, String> headers = {
    //"authorization":
    //"bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiIyIiwibmFtZWlkIjoiQWRtIiwidW5pcXVlX25hbWUiOiJBZG1pbmlzdHJhZG9yIiwicm9sZSI6IlRydWUiLCJQcm92aXNvcnlQYXNzd29yZCI6IkZhbHNlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9leHBpcmF0aW9uIjoiMDkvMTAvMjAyMyAwNDoxNjoyMyIsIm5iZiI6MTY5Njc5MjU4MywiZXhwIjoxNjk2ODM1NzgzLCJpYXQiOjE2OTY3OTI1ODN9.USlu95WQzp67B4RrZfC6gaON35IglpAVeC7mC1QK9LU",
    "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
  };

  static String url = "";

  static Future<ResponseModel<String>> getBaseUrl() async {
    var responseInfo = ResponseModel<String>();

    try {
      final response = await http
          .get(
            Uri.parse(Configuration.baseUrlStorage),
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
