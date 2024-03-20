// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastResponse _$ForecastResponseFromJson(Map<String, dynamic> json) =>
    ForecastResponse(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      daily: Daily.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForecastResponseToJson(ForecastResponse instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'daily': instance.daily,
    };

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
      apparentTemperatureMin:
          (json['apparent_temperature_min'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList(),
      apparentTemperatureMax:
          (json['apparent_temperature_max'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList(),
    );

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'time': instance.time,
      'apparent_temperature_min': instance.apparentTemperatureMin,
      'apparent_temperature_max': instance.apparentTemperatureMax,
    };
