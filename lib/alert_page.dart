//alert works here and logout
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AlertPage extends StatefulWidget {
  final String keyword;
  AlertPage({this.keyword});
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  bool alertOn = false;
  stt.SpeechToText _speech;
  bool _isListening = false;
  String text;
  String displayText = 'Press the button to start!!';
  //

  double level = 0.0;
  double minSoundLevel = 5000000000;
  double maxSoundLevel = -500000000;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void playSound() {
    final player = AudioCache();
    player.play('note1.wav');
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        finalTimeout: Duration(minutes: 1),
        debugLogging: true,
        onStatus: (val) {
          print('onStatus: $val');
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onSoundLevelChange: soundLevelListener,
          onResult: (result) {
            setState(() {
              text = result.recognizedWords;
              displayText = 'Listening...';
              List<String> words = text.split(' ');
              for (int i = 0; i < words.length; i++) {
                if (words[i] == widget.keyword) {
                  playSound();
                  print(words[i]);
                  setState(() {
                    displayText = 'Keyword found ' + words[i];
                    alertOn = true;
                  });
                  break;
                }
              }
            });
          },
        );
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    } else {
      setState(() {
        alertOn = false;
        _isListening = false;
        displayText = 'Press the button to start!!';
      });
      _speech.stop();
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Colors.blue,
        endRadius: 75,
        repeat: true,
        child: FloatingActionButton(
          onPressed: () {
            _listen();
          },
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Text(
                    displayText,
                    style: TextStyle(
                        fontSize: 20,
                        color: alertOn ? Colors.red : Colors.black,
                        fontWeight: alertOn ? FontWeight.bold : null),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
