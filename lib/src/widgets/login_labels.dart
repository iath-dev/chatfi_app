import 'package:flutter/material.dart';

class LoginLabels extends StatelessWidget {
  final String title, subtitle, path;
  const LoginLabels(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w300)),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, path),
              child: Text(title))
        ],
      ),
    );
  }
}
