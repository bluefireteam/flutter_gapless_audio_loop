# Gapless Audio Loop

A flutter plugin to enable gapless loops on Android and iOs.

Android may stills see some gaps on older versions like Android 6, newer versions of the SO seems to work fine.

The Android solution is heavily inspired by this [article](https://medium.com/@viksaaskool/gappless-sound-loop-on-android-1ddeccc563de).

At the moment this package is very simple and does not feature many media player functions, the focus on this package is to have a gapless loop, if you have suggestions to improve this package, please file an issue or send a PR.

If you need a more full-featured audio player, I suggest that you take a look on the [audioplayers package](https://github.com/luanpotter/audioplayers).

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


## Troubleshooting

These are some know reasons for audio files not looping perfect:

- Android 6 does not seems to loop perfectly the files for some reason.
- MP3 usually have gaps due to its compress format, for more info check [this question on stackexchange](https://sound.stackexchange.com/questions/8916/mp3-gapless-looping-help).
- _OGG files working only on Android:_ Unfortunately OGG is not support by iOs.
