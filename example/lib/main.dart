import 'package:flutter/material.dart';

import 'package:gapless_audio_loop/gapless_audio_loop.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GaplessAudioLoop _player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text("Play"),
                onPressed: () async {
                  final player = GaplessAudioLoop();
                  await player.load('Loop-Menu.wav');

                  await player.play();

                  setState(() {
                    _player = player;
                  });
                }),
            RaisedButton(
                child: Text("Stop"),
                onPressed: () {
                  if (_player != null) {
                    _player.stop();
                  }
                }),
            RaisedButton(
                child: Text("Pause"),
                onPressed: () {
                  if (_player != null) {
                    _player.pause();
                  }
                }),
            RaisedButton(
                child: Text("Resume"),
                onPressed: () {
                  if (_player != null) {
                    _player.resume();
                  }
                }),
            RaisedButton(
                child: Text("Seek to 5 secs"),
                onPressed: () {
                  if (_player != null) {
                    _player.seek(Duration(seconds: 5));
                  }
                }),
            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text("Volume"),
                        RaisedButton(
                                child: Text("0.2"),
                                onPressed: () {
                                    if (_player != null) {
                                        _player.setVolume(0.2);
                                    }
                                }),
                        RaisedButton(
                                child: Text("0.5"),
                                onPressed: () {
                                    if (_player != null) {
                                        _player.setVolume(0.5);
                                    }
                                }),
                        RaisedButton(
                                child: Text("1.0"),
                                onPressed: () {
                                    if (_player != null) {
                                        _player.setVolume(1.0);
                                    }
                                }),
                        ])
          ],
        ),
      ),
    );
  }
}
