import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/cubit/forecast_cubit.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/utils/string_utils.dart';
import 'package:weather_app/utils/weather_animation.dart';
import 'package:weather_app/widgets/max_temp_row.dart';
import 'package:weather_app/widgets/min_temp_row.dart';

import 'package:weather_app/widgets/weather_info_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  String city = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherCubit>(context).fetchWeatherCurrentCity();
    BlocProvider.of<ForecastCubit>(context).getForecast();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccess) {
            final weather = state.weatherResponse;

            city = weather.cityName;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextField(
                          controller: controller,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          city = controller.text;
                          BlocProvider.of<WeatherCubit>(context)
                              .getWeatherByCity(city);
                          BlocProvider.of<ForecastCubit>(context)
                              .getForecast(city: city);
                        },
                        child: const Text("Find city"),
                      ),
                    ],
                  ),
                  Lottie.asset(
                    getWeatherAnimation(weather.weather.main,
                        weather.sys.sunrise, weather.sys.sunset),
                  ),
                  Text(
                    city,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    '${(weather.mainInfo.temperature).toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 40.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherInfoCard(
                        title: 'Feels like',
                        info:
                            '${(weather.mainInfo.feelsLike).toStringAsFixed(1)}°C',
                      ),
                      WeatherInfoCard(
                        title: 'Pressure',
                        info:
                            '${(weather.mainInfo.pressure).toStringAsFixed(0)}hPa',
                      ),
                      WeatherInfoCard(
                        title: 'Wind speed',
                        info: '${(weather.wind.speed).toStringAsFixed(1)}m/s',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: screenHeight * 0.2,
                      child: BlocBuilder<ForecastCubit, ForecastState>(
                        builder: (context, state) {
                          if (state is ForecastSuccess) {
                            final forecastMin = state.tempMin.daily;
                            final forecastMax = state.tempMax.daily;
                            final itemCount = state.tempMin.daily.time.length;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: itemCount,
                              itemBuilder: (context, index) {
                                final minTemp =
                                    forecastMin.apparentTemperatureMin![index];
                                final maxTemp =
                                    forecastMax.apparentTemperatureMax![index];
                                final date = forecastMin.time[index];
                                String formattedDate = parseDate(date);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: screenHeight * 0.01,
                                    width: screenWidth * 0.3,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 88, 114, 159),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                          ),
                                        ),
                                        MinTempRow(minTemp: minTemp),
                                        MaxTempRow(maxTemp: maxTemp),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is WeatherFailure) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Failed to find searched city'),
                  IconButton(
                    onPressed: () =>
                        context.read<WeatherCubit>().fetchWeatherCurrentCity(),
                    icon: const Icon(
                      Icons.refresh,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
