import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_pieces/services/platform_services.dart';

class AuthenticationServices {
  static final String _baseApi = PlatformServices.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  static String _bearerToken = '';

  static String getBearerToken() {
    return _bearerToken;
  }

  static void setBearerToken(String bearerToken) {
    _bearerToken = bearerToken;
  }

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseApi/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    // If the login request is successful (status code 200),
    // extract the access token from the response and set it as the bearer token.
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      _bearerToken = result['access_token'];
    }
    print('This is from login: ${_bearerToken}');
    // Return true if the login request was successful, false otherwise.
    return response.statusCode == 200;
  }

  static Future<bool> logout() async {
    final response = await http.post(
      Uri.parse('$_baseApi/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_bearerToken'
      },
    );

    // Return true if the logout request was successful, false otherwise.
    return response.statusCode == 200;
  }
}
