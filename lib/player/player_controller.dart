import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:simple_radio/radio/sources.dart';

class PlayerController {
  final _player = FlutterRadioPlayer();

  // Signals del estado
  final currentIndex = signal(0);
  final volume = signal(0.5);
  final isPlaying = signal(false);
  final nowPlaying = signal<NowPlayingInfo?>(null);

  // Computed: fuente actual
  late final currentSource = computed(() => sources[currentIndex.value]);

  void initialize() {
    _player.initialize(sources, playWhenReady: true);

    // Conectar streams del player → signals
    _player.isPlayingStream.listen((value) => isPlaying.value = value);
    _player.nowPlayingStream.listen((value) => nowPlaying.value = value);
  }

  void jumpTo(int index) {
    currentIndex.value = index;
    _player.jumpToSourceAtIndex(index);
  }

  void previous() {
    jumpTo((currentIndex.value - 1 + sources.length) % sources.length);
  }

  void next() {
    jumpTo((currentIndex.value + 1) % sources.length);
  }

  void togglePlay() {
    isPlaying.value ? _player.pause() : _player.play();
  }

  void setVolume(double value) {
    volume.value = value;
    _player.setVolume(value);
  }

  void dispose() {
    _player.dispose();
    currentIndex.dispose();
    volume.dispose();
    isPlaying.dispose();
    nowPlaying.dispose();
    currentSource.dispose();
  }
}