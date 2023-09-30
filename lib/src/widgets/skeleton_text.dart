import 'package:flutter/material.dart';

class SkeletonText extends StatefulWidget {
  final double? width, height;

  const SkeletonText(
      {super.key, this.width = double.infinity, this.height = double.infinity});

  @override
  State<SkeletonText> createState() => _SkeletonTextState();
}

class _SkeletonTextState extends State<SkeletonText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _animation = Tween<double>(begin: -3, end: 10)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(_controller.value, 0),
                end: const Alignment(-1, 0),
                colors: const [
              Colors.black12,
              Colors.black26,
              Colors.black12
            ])),
      ),
    );
  }
}
