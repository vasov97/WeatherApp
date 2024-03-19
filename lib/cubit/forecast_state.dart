part of 'forecast_cubit.dart';

@immutable
sealed class ForecastState {}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState {}

class ForecastSuccess extends ForecastState {
  final List<ForecastItem> forecastResponse;
  ForecastSuccess({required this.forecastResponse});
}

class ForecastFailure extends ForecastState {
  final String errorMessage;

  ForecastFailure(this.errorMessage);
}
