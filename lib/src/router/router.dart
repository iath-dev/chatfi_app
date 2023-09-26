import 'package:flutter/material.dart';
import 'package:real_time_mobile_app/src/models/models.dart';
import 'package:real_time_mobile_app/src/screen/screen.dart';

class AppRoutes {
  static const String initialRoute = "login";

  static final Map<String, List<RouteItem>> routes = {
    'root': [
      RouteItem(path: 'home', screen: const HomeScreen()),
      RouteItem(path: 'login', screen: const LoginScreen()),
      RouteItem(path: 'chat', screen: const ChatScreen()),
      RouteItem(path: 'register', screen: const RegisterScreen()),
      RouteItem(path: 'loading', screen: const LoadingScreen()),
    ],
  };

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    final routes$ = routes.values.expand((element) => element).toList();

    for (final option in routes$) {
      appRoutes.addAll({option.path: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
