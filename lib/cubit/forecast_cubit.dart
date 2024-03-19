import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/env.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/repository/weather_repository.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit({required this.weatherRepository}) : super(ForecastInitial());

  final WeatherRepository weatherRepository;

  Future<void> getForecast(String city) async {
    final apiKey = Env.apiKey;

    try {
      emit(ForecastLoading());
      final resp =
          await weatherRepository.getForecastByCity(city, apiKey, 'metric', 4);
      emit(ForecastSuccess(forecastResponse: resp.list));
    } catch (e) {
      emit(ForecastFailure('Failed to retieve data:$e'));
    }
  }
}
