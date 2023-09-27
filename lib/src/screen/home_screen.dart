import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_mobile_app/src/models/models.dart';
import 'package:real_time_mobile_app/src/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = <UserModel>[
      UserModel(name: 'Daniel', email: 'daniel@gmail.com', uid: '123'),
      UserModel(name: 'Natalia', email: 'nata@gmail.com', uid: '456'),
      UserModel(name: 'David', email: 'david@gmail.com', uid: '789'),
      UserModel(name: 'Marcos', email: 'marc@gmail.com', uid: '741'),
      UserModel(name: 'Leo', email: 'leo@gmail.com', uid: '852'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        leading: IconButton(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.exit_to_app)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.signal_cellular_alt, color: Colors.green),
          )
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {},
        child: ListView.separated(
          separatorBuilder: (_, index) =>
              const Divider(height: 1, thickness: .75),
          itemCount: users.length,
          itemBuilder: (_, index) => _UserItem(user: users[index]),
        ),
      ),
    );
  }

  Future _handleLogout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.logout();
    Navigator.pushReplacementNamed(context, 'login');
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(child: Text(user.name.substring(0, 2))),
        trailing: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: user.online == ConnectionStatus.Online
                  ? Colors.green
                  : Colors.red),
        ),
        // dense: true,
        onTap: () => Navigator.pushNamed(context, 'chat'),
        title: Text(user.name));
  }
}
