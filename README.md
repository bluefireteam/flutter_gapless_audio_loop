# Gapless Audio Loop

Flutter plugin to enable gapless loops

Android solution heavily inspired by this article: https://medium.com/@viksaaskool/gappless-sound-loop-on-android-1ddeccc563de

# Usage

Drop it on your pubspec.yaml
```yaml
gapless_audio_loop: ^0.0.1
```

Import it:
```dart
import 'package:gapless_audio_loop/gapless_audio_loop.dart';
```

Loading and starting the loop:
```dart
final player = GaplessAudioLoop();
await player.load('Loop-Menu.wav');

await player.play();
```

To stop the loop just call `await player.stop()`
