import 'package:json_annotation/json_annotation.dart';

part 'forecast_response.g.dart';

@JsonSerializable()
class ForecastResponse {
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  @JsonKey(name: 'daily')
  final Daily daily;

  ForecastResponse({
    required this.latitude,
    required this.longitude,
    required this.daily,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseToJson(this);
}

@JsonSerializable()
class Daily {
  @JsonKey(name: 'time')
  final List<String> time;
  @JsonKey(name: 'apparent_temperature_min')
  final List<double>? apparentTemperatureMin;
  @JsonKey(name: 'apparent_temperature_max')
  final List<double>? apparentTemperatureMax;

  Daily({
    required this.time,
    required this.apparentTemperatureMin,
    required this.apparentTemperatureMax,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
