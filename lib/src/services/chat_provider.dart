import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_mobile_app/src/global/environment.dart';
import 'package:real_time_mobile_app/src/models/models.dart';
import 'package:real_time_mobile_app/src/services/services.dart';

class ChatService with ChangeNotifier {
  UserModel? _openUser;

  List<UserModel> _users = [];
  bool loading = false;

  List<UserModel> get users => _users;

  UserModel? get user => _openUser;
  set user(UserModel? value) {
    _openUser = value;
    notifyListeners();
  }

  ChatService() {
    getUsers();
  }

  Future<void> getUsers() async {
    loading = true;
    notifyListeners();

    final token = await AuthService.getToken();
    final Uri uri = Uri.parse('${Environment.api}/chat/users');

    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    _users = UsersResponse.fromRawJson(res.body).users;

    loading = false;
    notifyListeners();
  }

  Future<ChatRoomResponse> getChatRoom(String receiver) async {
    final token = await AuthService.getToken();
    final Uri uri = Uri.parse('${Environment.api}/chat/room');
    final res = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'receiver': receiver}));

    return ChatRoomResponse.fromRawJson(res.body);
  }

  Future<ChatHistoryResponse> getChatHistory(String receiver) async {
    final token = await AuthService.getToken();
    final Uri uri = Uri.parse('${Environment.api}/chat/messages/$receiver');
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    return ChatHistoryResponse.fromRawJson(res.body);
  }
}
