import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class HttpService {
  String url = "";
  Future<HttpServiceResponse> get(
      {@required String? endpoint, Map<String, String>? headers}) async {
    try {
      Response response = await http.get(Uri.parse(url + "/" + endpoint!),
          headers: headers ?? {});
      return validateResponse(response);
    } catch (e) {
      return HttpServiceResponse(success: false, message: "");
    }
  }

  Future<HttpServiceResponse> post(
      {required String endpoint,
      required Map<String, dynamic> body,
      required Map<String, String>? headers}) async {
    try {
      Response response = await http.post(Uri.parse(url + "/" + endpoint),
          body: json.encode(body), headers: headers);
      return validateResponse(response);
    } catch (e) {
      return HttpServiceResponse(success: false, message: "");
    }
  }

  Future<HttpServiceResponse> put(
      {required String endpoint,
      required Map<String, dynamic> body,
      required Map<String, String>? headers}) async {
    try {
      Response response = await http.put(Uri.parse(url + "/" + endpoint),
          body: json.encode(body), headers: headers ?? {});
      return validateResponse(response);
    } catch (e) {
      return HttpServiceResponse(success: false, message: "");
    }
  }

  Future<HttpServiceResponse> validateResponse(Response response) async {
    String message = "ERROR";
    switch (response.statusCode) {
      case 200:
      case 201:
        return HttpServiceResponse(
            success: true, body: response.body, message: "");
        break;

      default:
        return HttpServiceResponse(success: false, message: message);
    }
  }
}

HttpService httpService = HttpService();

class HttpServiceResponse {
  bool? success;
  String? message;
  String? body;

  HttpServiceResponse({this.success, this.message, this.body});

  HttpServiceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['body'] = body;
    return data;
  }
}
