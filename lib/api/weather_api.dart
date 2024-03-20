import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/models/weather_response.dart';

part 'weather_api.g.dart';

@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5")
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET("/weather")
  Future<WeatherResponse> getWeatherByCity(
    @Query('q') String cityName,
    @Query('appid') String apiKey,
    @Query('units') String units,
  );

  @GET("/weather")
  Future<WeatherResponse> getCurrentWeather(
    @Query('lat') double latitude,
    @Query('lon') double longitude,
    @Query('appid') String apiKey,
    @Query('units') String units,
  );
}
