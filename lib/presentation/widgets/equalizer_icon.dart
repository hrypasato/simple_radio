import 'package:flutter/material.dart';

class EqualizerIcon extends StatelessWidget {
  final bool isPlaying;
  final Color color;

  const EqualizerIcon({
    super.key,
    required this.isPlaying,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _Bar(isPlaying: isPlaying, color: color, delay: 0),
          _Bar(isPlaying: isPlaying, color: color, delay: 150),
          _Bar(isPlaying: isPlaying, color: color, delay: 300),
        ],
      ),
    );
  }
}

class _Bar extends StatefulWidget {
  final bool isPlaying;
  final Color color;
  final int delay;

  const _Bar({required this.isPlaying, required this.color, required this.delay});

  @override
  State<_Bar> createState() => _BarState();
}

class _BarState extends State<_Bar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400 + widget.delay),
  );

  @override
  void initState() {
    super.initState();
    if (widget.isPlaying) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_Bar old) {
    super.didUpdateWidget(old);
    widget.isPlaying
        ? _controller.repeat(reverse: true)
        : _controller.animateTo(0.2);
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
      builder: (_, _) => Container(
        width: 4,
        height: 6 + (14 * _controller.value), // mín 6px, máx 20px
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}