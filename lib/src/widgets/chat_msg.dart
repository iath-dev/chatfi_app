import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message, uid;

  const ChatMessage({super.key, required this.message, required this.uid});

  @override
  Widget build(BuildContext context) {
    final isOwn = int.parse(uid).isEven;

    return isOwn
        ? _MessageBubble(
            message: message,
            align: Alignment.centerRight,
            color: Theme.of(context).colorScheme.primaryContainer,
            textColor: Theme.of(context).colorScheme.onPrimaryContainer)
        : _MessageBubble(
            message: message,
            align: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            textColor: Theme.of(context).colorScheme.onTertiaryContainer);
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final Alignment align;
  final Color color, textColor;

  const _MessageBubble({
    super.key,
    required this.message,
    required this.align,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeIn(
      animate: true,
      duration: const Duration(milliseconds: 700),
      child: Align(
        alignment: align,
        child: Container(
          padding: const EdgeInsets.all(8),
          constraints: BoxConstraints(
              maxWidth: size.width * .6, minWidth: size.width * .3),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 2, offset: Offset(2, 2))
          ], color: color, borderRadius: BorderRadius.circular(8)),
          child: Text(message,
              style: TextStyle(
                color: textColor,
              )),
        ),
      ),
    );
  }
}
