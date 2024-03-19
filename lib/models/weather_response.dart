import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: 'name')
  final String cityName;

  @JsonKey(name: 'main')
  final Main mainInfo;

  @JsonKey(name: 'wind')
  final Wind wind;

  @JsonKey(name: 'weather')
  final Condition weather;

  @JsonKey(name: 'sys')
  final Sys sys;

  WeatherResponse({
    required this.cityName,
    required this.mainInfo,
    required this.wind,
    required this.weather,
    required this.sys,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class Main {
  @JsonKey(name: 'temp')
  final double temperature;

  @JsonKey(name: 'feels_like')
  final double feelsLike;

  @JsonKey(name: 'pressure')
  final double pressure;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Main({
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
  });

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind {
  @JsonKey(name: 'speed')
  final double speed;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Wind({
    required this.speed,
  });

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Condition {
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'main')
  final String main;

  Condition({
    required this.main,
    required this.description,
  });

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

@JsonSerializable()
class Sys {
  @JsonKey(name: 'sunrise')
  final int sunrise;

  @JsonKey(name: 'sunset')
  final int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Sys({
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toJson() => _$SysToJson(this);
}
