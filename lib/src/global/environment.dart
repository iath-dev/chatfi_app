import 'dart:io';

class Environment {
  static String api = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';

  static String socket =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
