import 'package:flutter/material.dart';

class VolumeSlider extends StatelessWidget {
  final ValueChanged<double> onChangeVolume;
  final double volume;
  const VolumeSlider({
    super.key,
    required this.onChangeVolume,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Icon(Icons.volume_down_rounded, color: colorScheme.onSurfaceVariant),
          Expanded(
            child: Slider(value: volume, onChanged: onChangeVolume),
          ),
          Icon(Icons.volume_up_rounded, color: colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
