import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/models/forecast_response.dart';

part 'open_meteo_api.g.dart';

@RestApi(baseUrl: "https://api.open-meteo.com/")
abstract class OpenMeteoApi {
  factory OpenMeteoApi(Dio dio, {String baseUrl}) = _OpenMeteoApi;

  @GET("/v1/forecast")
  Future<ForecastResponse> getMinTemperature(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('daily') String daily,
  );
}
