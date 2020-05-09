### Deprecated

This package is no longer maintained as this solution does not works well on Android 9 anymore. To get gapless loop plays, use this [library instead](https://github.com/erickzanardo/ocarina)

# Gapless Audio Loop

A flutter plugin to enable gapless loops on Android and iOs.

Android may stills see some gaps on older versions like Android 6, newer versions of the SO seems to work fine.

The Android solution is heavily inspired by this [article](https://medium.com/@viksaaskool/gappless-sound-loop-on-android-1ddeccc563de).

At the moment this package is very simple and does not feature many media player functions, the focus on this package is to have a gapless loop, if you have suggestions to improve this package, please file an issue or send a PR.

If you need a more full-featured audio player, I suggest that you take a look on the [audioplayers package](https://github.com/luanpotter/audioplayers).

# Usage

Drop it on your pubspec.yaml
```yaml
gapless_audio_loop: ^1.1.0
```

Import it:
```dart
import 'package:gapless_audio_loop/gapless_audio_loop.dart';
```

Loading and starting the loop:
```dart
final player = GaplessAudioLoop();
await player.loadAsset('Loop-Menu.wav'); // use loadFile instead to use a file from the device storage

await player.play();
```

To stop the loop just call `await player.stop()`

You can also pause and resume using the `pause` and `resume` methods.

## Volume

Audio volume can be changed using the the `setVolume` method, which receives a double between 0 and 1, which represents the percentage of the total volume of the device, example, if you pass `0.5` it means that the audio will play on 50% of the total volume.

## Seek

Seeking can be done by the `seek` method, which receives a `Duration` object, beware that since this is a looping library, if you call seek to a value bigger than the total duration of the file, unexpected behaviour may occur, so it is highly recommend to avoid that and only use durations that are inside the total length of the file.

## Troubleshooting


These are some know reasons for audio files not looping perfect:

- Android 6 does not seems to loop perfectly the files for some reason.
- MP3 usually have gaps due to its compress format, for more info check [this question on stackexchange](https://sound.stackexchange.com/questions/8916/mp3-gapless-looping-help).
- _OGG files working only on Android:_ Unfortunately OGG is not support by iOs.
