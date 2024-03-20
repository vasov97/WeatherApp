import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather_app/api/open_meteo_api.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/cubit/forecast_cubit.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/repository/weather_repository.dart';

class AppDependencies {
  final BuildContext context;
  static AppDependencies? _instance;

  AppDependencies._(this.context);

  factory AppDependencies.of(BuildContext context) =>
      _instance != null ? _instance! : _instance = AppDependencies._(context);

  List<SingleChildWidget> get providers => [
        ..._dio,
        ..._api,
        ..._repositories,
        ..._cubits,
      ];
  List<Provider> get _dio => [
        Provider<Dio>(
          create: (context) => Dio(),
        ),
      ];
  List<SingleChildWidget> get _api => [
        Provider<WeatherApi>(
          create: (context) => WeatherApi(
            context.read(),
          ),
        ),
        Provider<OpenMeteoApi>(
          create: (context) => OpenMeteoApi(
            context.read(),
          ),
        ),
      ];

  List<SingleChildWidget> get _repositories => [
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
            context.read(),
            context.read(),
          ),
        ),
      ];

  List<SingleChildWidget> get _cubits => [
        Provider<WeatherCubit>(
          create: (context) => WeatherCubit(
            weatherRepository: context.read(),
          ),
        ),
        Provider<ForecastCubit>(
          create: (context) => ForecastCubit(
            weatherRepository: context.read(),
          ),
        ),
      ];
}
