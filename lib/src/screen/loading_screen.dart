import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_mobile_app/src/services/services.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: FutureBuilder(
        future: _validToken(context),
        builder: (context, snapshot) => Center(
          child: Pulse(
              infinite: true,
              child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset(
                    'assets/chatfi.png',
                    fit: BoxFit.cover,
                  ))),
        ),
      ),
    );
  }

  Future _validToken(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final res = await authService.isLoggedIn();

    if (res) {
      socketService.connect();
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
