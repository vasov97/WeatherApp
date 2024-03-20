import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer player;

  AudioManager(this.player);

  void playSound() async {
    await player.play(AssetSource('night.mp3'));
    loop();
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }
}
