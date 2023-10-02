import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_mobile_app/src/models/models.dart';
import 'package:real_time_mobile_app/src/services/services.dart';
import 'package:real_time_mobile_app/src/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late UserModel user;
  late ChatService chatService;
  late SocketService socketService;

  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);

    if (chatService.user == null) {
      Navigator.pushReplacementNamed(context, 'loading');
    }

    user = chatService.user!;

    socketService.socket.on('message', _listenMessage);

    chatService.getChatHistory(user.uid).then((value) {
      setState(() {
        messages = value.data
            .map((e) => ChatMessage(message: e.message, uid: e.from))
            .toList();
      });
    });
  }

  _listenMessage(dynamic data) {
    final input = InputMessage.fromJson(data);

    ChatMessage msg = ChatMessage(message: input.message, uid: input.from);

    setState(() {
      messages.insert(0, msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 18,
              child: Text(user.name.substring(0, 2)),
            ),
            const SizedBox(width: 8),
            Text(
              user.name,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemBuilder: (_, index) => messages[index],
            ),
          ),
          _MessageInputBox(onSubmit: (msg) {
            setState(() {
              messages.insert(
                  0, ChatMessage(message: msg.message, uid: msg.from));
            });
          })
        ],
      ),
    );
  }
}

class _MessageInputBox extends StatefulWidget {
  final Function(InputMessage msg) onSubmit;
  const _MessageInputBox({super.key, required this.onSubmit});

  @override
  State<_MessageInputBox> createState() => _MessageInputBoxState();
}

class _MessageInputBoxState extends State<_MessageInputBox> {
  final TextEditingController _controller = TextEditingController();
  final _focus = FocusNode();
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              onSubmitted: _handleSubmit,
              onChanged: (value) => setState(() {
                _isWriting = value.isNotEmpty;
              }),
              controller: _controller,
              focusNode: _focus,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            ),
          ),
          IconButton(
              onPressed:
                  _isWriting ? () => _handleSubmit(_controller.text) : null,
              icon: const Icon(Icons.send),
              color: Theme.of(context).colorScheme.onPrimaryContainer)
        ],
      ),
    );
  }

  void _handleSubmit(String value) {
    if (value.isEmpty) return;

    final socketService = Provider.of<SocketService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final chatService = Provider.of<ChatService>(context, listen: false);

    _controller.clear();
    _focus.requestFocus();

    final msg = {
      'from': authService.user.uid,
      'to': chatService.user!.uid,
      'message': value
    };

    socketService.socket.emit('message', msg);

    widget.onSubmit(InputMessage.fromJson(msg));
  }
}
