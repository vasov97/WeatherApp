part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final WeatherResponse weatherResponse;
  // final ForecastResponse forecastResponse;

  WeatherSuccess({
    required this.weatherResponse,
  });
}

class WeatherFailure extends WeatherState {
  final String errorMessage;

  WeatherFailure(this.errorMessage);
}
