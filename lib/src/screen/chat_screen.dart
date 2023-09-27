import 'package:flutter/material.dart';
import 'package:real_time_mobile_app/src/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 18,
              child: Text('ab'),
            ),
            SizedBox(width: 12),
            Text(
              'Nombre',
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
              itemCount: 200,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemBuilder: (context, index) => ChatMessage(
                  message:
                      'Lorem do consequat voluptate irure quis ipsum nisi ullamco Lorem consectetur duis officia.',
                  uid: '$index'),
            ),
          ),
          const _MessageInputBox()
        ],
      ),
    );
  }
}

class _MessageInputBox extends StatefulWidget {
  const _MessageInputBox({
    super.key,
  });

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

    print('msg: ${_controller.text}');

    _controller.clear();
    _focus.requestFocus();
  }
}
