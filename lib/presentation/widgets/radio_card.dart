import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:simple_radio/presentation/widgets/equalizer_icon.dart';

class RadioCard extends StatelessWidget {
  final VoidCallback onSourceTap;
  final bool isActive;
  final RadioSource source;

  const RadioCard({
    super.key,
    required this.onSourceTap,
    required this.isActive,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      selected: isActive,
      selectedTileColor: colorScheme.primaryContainer.withValues(alpha: 0.3),
      leading: CircleAvatar(
        backgroundColor: isActive
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
        child: isActive
      ? EqualizerIcon(          // ← barras animadas
          isPlaying: isActive,
          color: colorScheme.onPrimary,
        )
      : Icon(
          Icons.radio_rounded,
          color: colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ),
      title: Text(source.title ?? source.url),
      subtitle: isActive
          ? Text('Now playing', style: TextStyle(color: colorScheme.primary))
          : null,
      onTap: onSourceTap,
    );
  }
}
