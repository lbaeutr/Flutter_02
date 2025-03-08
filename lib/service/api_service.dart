import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data);

    print('POST request to $url');
    print('Headers: $headers');
    print('Body: $body');

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<void> login(String username, String password) async {
    final response = await post('/usuarios/login', {
      'username': username,
      'password': password,
    });

    if (response.containsKey('token')) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
    } else {
      throw Exception('Failed to retrieve token');
    }
  }
}