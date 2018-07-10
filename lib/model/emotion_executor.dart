import 'package:tts/tts.dart';
import 'package:audioplayer/audioplayer.dart';

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
    Tts.speak("You are angry. Take a deep breath");
  }
}

class HappyEmotionStrategy extends EmotionStrategy {
  @override
  void run() {
    AudioPlayer player = new AudioPlayer();
    player.play("http://www.rxlabz.com/labz/audio.mp3");
  }
}
