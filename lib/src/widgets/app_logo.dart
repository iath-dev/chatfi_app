import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final String title;

  const AppLogo({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 180,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            'assets/chatfi.png',
            height: 180,
            fit: BoxFit.cover,
          ),
          if (title.isNotEmpty)
            Text(
              title,
              style: TextStyle(
                  fontSize: 35, color: Theme.of(context).primaryColor),
            )
        ],
      ),
    );
  }
}
