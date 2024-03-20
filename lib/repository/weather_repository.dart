import 'package:weather_app/api/open_meteo_api.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/models/weather_response.dart';

class WeatherRepository {
  final WeatherApi _weatherApi;
  final OpenMeteoApi _openMeteoApi;

  WeatherRepository(
    this._weatherApi,
    this._openMeteoApi,
  );

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

  Future<ForecastResponse> getForecast(
      double latitude, double longitude, String daily) async {
    try {
      final response =
          await _openMeteoApi.getMinTemperature(latitude, longitude, daily);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ForecastResponse> getForecastByCity(
      double latitude, double longitude, String daily) async {
    try {
      final response =
          await _openMeteoApi.getMinTemperature(latitude, longitude, daily);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<Map<String, dynamic>> fetchForecast() async {
  //   final Uri url = Uri.parse(
  //       'https://api.open-meteo.com/v1/forecast?latitude=44.804&longitude=20.4651&daily=apparent_temperature_min');

  //   final response = await http.get(url);
  //   print(response.body);
  //   print(response.body[5]);
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to load forecast');
  //   }
  // }

  // Future<ForecastMaxResponse> getMaxForecast(
  //     double latitude, double longitude, String daily) async {
  //   try {
  //     final response =
  //         await _openMeteoApi.getMaxTemperature(latitude, longitude, daily);
  //     return response;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
