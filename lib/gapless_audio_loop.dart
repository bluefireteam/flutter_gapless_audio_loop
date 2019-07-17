import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/services.dart';

class GaplessAudioLoop {
  static const MethodChannel _channel =
      const MethodChannel('gapless_audio_loop');

  /// A reference to the loaded file.
  File _loadedFile;
  int _id;

  Future<ByteData> _fetchAsset(String fileName) async {
    return await rootBundle.load('assets/$fileName');
  }

  Future<File> _fetchToMemory(String fileName) async {
    final file = File('${(await getTemporaryDirectory()).path}/$fileName');
    await file.create(recursive: true);
    return await file
        .writeAsBytes((await _fetchAsset(fileName)).buffer.asUint8List());
  }


  /// Load the [fileName] for playing
  ///
  Future<void> load(String fileName) async {
    if (_loadedFile != null) {
      return _loadedFile;
    }

    _loadedFile = await _fetchToMemory(fileName);
  }

  Future<void> play() async {
    assert(_loadedFile != null, 'File is not loaded');

    _id = await _channel.invokeMethod("play", { 'url': _loadedFile.path });
  }

  Future<void> stop() async {
    assert(_loadedFile != null, 'File is not loaded');
    assert(_id != null, 'Loop is not playing');

    await _channel.invokeMethod("stop", { 'playerId': _id });
  }
}
