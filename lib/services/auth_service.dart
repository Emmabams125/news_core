import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'network_constants.dart';

class AuthService {
  // REGISTER USER
  static Future<http.Response> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${NetworkConstants.baseUrl}/register"),
    );

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  // LOGIN USER
  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) async {
    return await http.post(
      Uri.parse("${NetworkConstants.baseUrl}/login"),
      headers: NetworkConstants.headers,
      body: jsonEncode({"email": email, "password": password}),
    );
  }
}
