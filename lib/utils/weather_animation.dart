String getWeatherAnimation(String? condition, int sunrise, int sunset) {
  var currentTime = DateTime.now();
  var sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
  //var sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
  bool isDayTime = currentTime.isAfter(sunriseTime);
  if (condition == null) {
    return isDayTime ? 'assets/sunny.json' : 'assets/night_clear.json';
  }
  switch (condition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return isDayTime ? 'assets/clouds.json' : 'assets/night_clouds.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return isDayTime ? 'assets/rain.json' : 'assets/night_rain.json';
    case 'thunderstrom':
      return isDayTime ? 'assets/thunder.json' : 'assets/night_thunder.json';
    case 'clear':
      return isDayTime ? 'assets/sunny.json' : 'assets/night_clear.json';
    case 'snow':
      return isDayTime ? 'assets/snow.json' : 'assets/night_snow.json';
    default:
      return isDayTime ? 'assets/sunny.json' : 'assets/night_clear.json';
  }
}
