import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gapless_audio_loop/gapless_audio_loop.dart';

void main() {
  const MethodChannel channel = MethodChannel('gapless_audio_loop');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GaplessAudioLoop.platformVersion, '42');
  });
}
