import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/weather_response.dart';

part 'forecast_response.g.dart';

@JsonSerializable()
class ForecastResponse {
  final List<ForecastItem> list;

  ForecastResponse({required this.list});

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseToJson(this);
}

@JsonSerializable()
class ForecastItem {
  @JsonKey(name: 'temp')
  final Temp temp;

  @JsonKey(name: 'dt')
  final int dt;

  ForecastItem({
    required this.temp,
    required this.dt,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) =>
      _$ForecastItemFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastItemToJson(this);
}

@JsonSerializable()
class Temp {
  @JsonKey(name: 'max')
  final double max;

  @JsonKey(name: 'min')
  final double min;

  Temp({
    required this.min,
    required this.max,
  });

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);

  Map<String, dynamic> toJson() => _$TempToJson(this);
}
