import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/env.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepository}) : super(WeatherInitial());

  final WeatherRepository weatherRepository;

  Future<void> getWeatherByCity(String city) async {
    final apiKey = Env.apiKey;

    try {
      emit(WeatherLoading());
      final resp =
          await weatherRepository.getWeatherByCity(city, apiKey, 'metric');

      emit(
        WeatherSuccess(weatherResponse: resp),
      );
    } catch (e) {
      emit(WeatherFailure('Failed to retieve data:$e'));
    }
  }

  Future<void> fetchWeatherCurrentCity() async {
    final apiKey = Env.apiKey;
    try {
      emit(WeatherLoading());
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final resp = await weatherRepository.getCurrentWeather(
          position.latitude, position.longitude, apiKey, 'metric');

      emit(WeatherSuccess(weatherResponse: resp));
    } catch (e) {
      emit(WeatherFailure('Failed to retieve data:$e'));
    }
  }
}
