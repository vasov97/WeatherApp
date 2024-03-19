import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/models/weather_response.dart';

class WeatherRepository {
  final WeatherApi _weatherApi;

  WeatherRepository(this._weatherApi);

  Future<WeatherResponse> getWeatherByCity(
      String city, String apiKey, String units) async {
    try {
      final weatherResponse =
          await _weatherApi.getWeatherByCity(city, apiKey, units);
      return weatherResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<WeatherResponse> getCurrentWeather(
      double latitude, double longitude, String apiKey, String units) async {
    try {
      final weatherResponse = await _weatherApi.getCurrentWeather(
          latitude, longitude, apiKey, units);
      return weatherResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ForecastResponse> getForecastByCity(
      String city, String apiKey, String units, int days) async {
    try {
      final weatherResponse =
          await _weatherApi.getForecastByCity(city, apiKey, units, days);
      return weatherResponse;
    } catch (e) {
      throw Exception(e);
    }
  }
}
