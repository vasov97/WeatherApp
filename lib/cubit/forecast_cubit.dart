import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/env.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/repository/weather_repository.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit({required this.weatherRepository}) : super(ForecastInitial());

  final WeatherRepository weatherRepository;

  Future<void> getForecast({String? city}) async {
    emit(ForecastLoading());
    if (city == null || city.isEmpty) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final forecastResponseMin = await weatherRepository.getForecast(
          position.latitude,
          position.longitude,
          "apparent_temperature_min",
        );
        final forecastResponseMax = await weatherRepository.getForecast(
          position.latitude,
          position.longitude,
          "apparent_temperature_max",
        );
        emit(ForecastSuccess(
            tempMin: forecastResponseMin, tempMax: forecastResponseMax));
      } catch (e) {
        emit(ForecastFailure(e.toString()));
      }
    } else {
      double latitude = 0;
      double longitude = 0;
      List<Location> locations = await locationFromAddress(city);
      try {
        if (locations.isNotEmpty) {
          latitude = locations[0].latitude;
          longitude = locations[0].longitude;
          final forecastResponseMin = await weatherRepository.getForecast(
            latitude,
            longitude,
            "apparent_temperature_min",
          );
          final forecastResponseMax = await weatherRepository.getForecast(
            latitude,
            longitude,
            "apparent_temperature_max",
          );
          emit(ForecastSuccess(
              tempMin: forecastResponseMin, tempMax: forecastResponseMax));
        }
      } catch (e) {
        emit(ForecastFailure(e.toString()));
      }
    }
  }
}
