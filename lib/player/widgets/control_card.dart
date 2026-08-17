import 'package:flutter/material.dart';

class ControlCard extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onTogglePlay;

  const ControlCard({
    super.key,
    required this.isPlaying,
    required this.onPrevious,
    required this.onNext,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 36,
          onPressed: onPrevious,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        const SizedBox(width: 16),
        FilledButton.tonal(
          style: FilledButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: onTogglePlay,
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 40,
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          iconSize: 36,
          onPressed: onNext,
          icon: const Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}
