import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_time_mobile_app/src/global/environment.dart';
import 'package:real_time_mobile_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  late UserModel _user;

  final _storage = const FlutterSecureStorage();

  UserModel get user => _user;

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return storage.read(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final Uri uri = Uri.parse('${Environment.api}/auth/login');

    final res = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (res.statusCode != 200) return false;

    final response = LoginAuthResponse.fromRawJson(res.body);

    _user = response.data;

    await _storage.write(key: 'token', value: response.accessToken);

    return true;
  }

  Future<bool> register(String name, String email, String password) async {
    final data = {'name': name, 'email': email, 'password': password};
    final Uri uri = Uri.parse('${Environment.api}/auth/register');

    final res = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (res.statusCode != 200) return false;

    final response = LoginAuthResponse.fromRawJson(res.body);

    _user = response.data;

    await _storage.write(key: 'token', value: response.accessToken);

    return true;
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final Uri uri = Uri.parse('${Environment.api}/auth/validate');

    final res = await http.post(uri, body: null, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (res.statusCode != 200) return false;

    final response = LoginAuthResponse.fromRawJson(res.body);

    _user = response.data;

    await _storage.write(key: 'token', value: response.accessToken);

    return true;
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
