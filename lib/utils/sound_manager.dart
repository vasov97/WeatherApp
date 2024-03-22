import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer player;

  AudioManager(this.player);

  void playSound(String sound) async {
    await player.play(AssetSource('$sound.mp3'));
    loop();
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }

  void playSoundForWeather(String? condition, bool isDayTime) {
    switch (condition!.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return playSound('rain');
      case 'thunderstrom':
        return playSound('thunder');
      case 'snow':
        return playSound('snow');
      default:
        return isDayTime ? playSound('spring') : playSound('night');
    }
  }
}
