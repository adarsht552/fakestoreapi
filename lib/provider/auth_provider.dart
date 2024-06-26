import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  late String _token = '';

  String get token => _token;

  bool get isAuth => _token.isNotEmpty;

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        body: jsonEncode({
          'username': username,
          'password': password
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', _token);
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      print('Login error: $error');
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return false;
    }

    _token = prefs.getString('token')!;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = '';
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
