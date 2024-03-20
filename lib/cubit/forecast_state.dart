part of 'forecast_cubit.dart';

@immutable
sealed class ForecastState {}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState {}

class ForecastSuccess extends ForecastState {
  //Map<String, dynamic> tempMin;
  ForecastResponse tempMin, tempMax;
  ForecastSuccess({
    required this.tempMin,
    required this.tempMax,
  });
}

class ForecastFailure extends ForecastState {
  final String errorMessage;

  ForecastFailure(this.errorMessage);
}
