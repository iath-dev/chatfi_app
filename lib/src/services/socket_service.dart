import 'package:flutter/material.dart';
import 'package:real_time_mobile_app/src/global/environment.dart';
import 'package:real_time_mobile_app/src/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum ServerConnectionStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  late Socket _socket;
  ServerConnectionStatus _status = ServerConnectionStatus.Connecting;

  ServerConnectionStatus get status => _status;
  Socket get socket => _socket;

  void connect() async {
    final String? token = await AuthService.getToken();

    _socket = io(
        Environment.socket,
        OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableForceNew()
            .setAuth({'access_token': token})
            .build());

    _socket.onConnect((_) {
      _status = ServerConnectionStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _status = ServerConnectionStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
