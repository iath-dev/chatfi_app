import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_mobile_app/src/models/models.dart';
import 'package:real_time_mobile_app/src/services/services.dart';
import 'package:real_time_mobile_app/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final chatService = Provider.of<ChatService>(context);

    final loading = chatService.loading;
    final users = chatService.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        leading: IconButton(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.exit_to_app)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _getSignalIcon(socketService.status),
          )
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: chatService.getUsers,
        child: ListView.separated(
          separatorBuilder: (_, index) =>
              const Divider(height: 1, thickness: .75),
          itemCount: loading ? 5 : users.length,
          itemBuilder: (_, index) => loading
              ? _LoadingSkeleton()
              : FadeIn(child: _UserItem(user: users[index])),
        ),
      ),
    );
  }

  Icon _getSignalIcon(ServerConnectionStatus status) {
    switch (status) {
      case ServerConnectionStatus.Online:
        return const Icon(Icons.signal_cellular_alt, color: Colors.green);
      case ServerConnectionStatus.Offline:
      default:
        return const Icon(
          Icons.signal_cellular_alt_1_bar_rounded,
          color: Colors.red,
        );
    }
  }

  Future _handleLogout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.disconnect();
    authService.logout();
    Navigator.pushReplacementNamed(context, 'login');
  }
}

class _LoadingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        height: 40,
        width: 100,
        child: const SkeletonText());
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
              color: user.status == ConnectionStatus.Online
                  ? Colors.green
                  : Colors.red),
        ),
        // dense: true,
        onTap: () {
          Provider.of<ChatService>(context, listen: false).user = user;
          Navigator.pushNamed(context, 'chat');
        },
        dense: true,
        subtitle: Text(user.email),
        title: Text(user.name));
  }
}
