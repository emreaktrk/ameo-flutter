import 'package:tts/tts.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:call_number/call_number.dart';

class EmotionExecutor {
  void execute(EmotionStrategy strategy) {
    strategy.run();
  }
}

abstract class EmotionStrategy {
  void run();
}

class AngryEmotionStrategy extends EmotionStrategy {
  @override
  void run() {
    Tts.speak("You are angry. Take a deep breath.");
  }
}

class HappyEmotionStrategy extends EmotionStrategy {
  @override
  void run() {
    AudioPlayer player = new AudioPlayer();
    player.play("http://www.rxlabz.com/labz/audio.mp3");
  }
}

class ScaredEmotionStrategy extends EmotionStrategy {
  @override
  void run() {
    Tts.speak("1... 2... 3... 4... 5...");
  }
}

class NeutralEmotionStrategy extends EmotionStrategy {
  @override
  void run() {
    CallNumber().callNumber("+905303401905");
  }
}
