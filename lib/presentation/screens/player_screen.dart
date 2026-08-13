import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:simple_radio/core/sources.dart';
import 'package:simple_radio/presentation/widgets/artwork.dart';
import 'package:simple_radio/presentation/widgets/control_card.dart';
import 'package:simple_radio/presentation/widgets/info_card.dart';
import 'package:simple_radio/presentation/widgets/radio_card.dart';
import 'package:simple_radio/presentation/widgets/volume_slider.dart';
import 'package:simple_radio/services/radio_controller.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // El controlador vive aquí, no se recrea en rebuilds
  final _controller = RadioController();

  @override
  void initState() {
    super.initState();
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Artwork(),
            const SizedBox(height: 24),

            // ✅ Reemplaza StreamBuilder<NowPlayingInfo>
            SignalBuilder(
              builder: (context) {
                final title =
                    _controller.nowPlaying.value?.title ??
                    _controller.currentSource.value.title ??
                    'Unknown Station';
                return InfoCard(
                  title: title,
                  source: _controller.currentSource.value.title,
                );
              },
            ),
            const SizedBox(height: 32),

            // ✅ Reemplaza StreamBuilder<bool>
            SignalBuilder(
              builder: (context) {
                return ControlCard(
                  isPlaying: _controller.isPlaying.value,
                  onPrevious: _controller.previous,
                  onNext: _controller.next,
                  onTogglePlay: _controller.togglePlay,
                );
              },
            ),
            const SizedBox(height: 24),

            // ✅ Solo Watch en el slider
            SignalBuilder(
              builder: (context) => VolumeSlider(
                volume: _controller.volume.value,
                onChangeVolume: _controller.setVolume,
              ),
            ),

            const Spacer(),

            // ✅ Lista de estaciones — Watch solo en la tarjeta activa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      'STATIONS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  ...List.generate(sources.length, (index) {
                    return SignalBuilder(
                      builder: (context) => RadioCard(
                        onSourceTap: () => _controller.jumpTo(index),
                        // Solo este Watch se reconstruye al cambiar de estación
                        isActive: _controller.currentIndex.value == index,
                        source: sources[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
