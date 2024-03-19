import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/cubit/forecast_cubit.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/utils/weather_animation.dart';

import 'package:weather_app/widgets/weather_info_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  String city = '';
  final player = AudioPlayer();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherCubit>(context).fetchWeatherCurrentCity();
    BlocProvider.of<ForecastCubit>(context).getForecast('Belgrade');
  }

  void playSound() async {
    await player.play(AssetSource('night.mp3'));
    loop();
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  Widget build(BuildContext context) {
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
            // final forecast = state.forecastResponse;
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
                          BlocProvider.of<WeatherCubit>(context)
                              .getWeatherByCity(controller.text);
                          city = controller.text;
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
                  BlocBuilder<ForecastCubit, ForecastState>(
                    builder: (context, state) {
                      if (state is ForecastSuccess) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.forecastResponse.length,
                          itemBuilder: (context, index) {
                            final forecastItem = state.forecastResponse[index];
                            final date = DateTime.fromMillisecondsSinceEpoch(
                                forecastItem.dt * 1000);
                            return ListTile(
                              title: Text(
                                  'Date: ${DateFormat('yyyy-MM-dd').format(date)}'),
                              subtitle: Text(
                                  'Min Temp: ${forecastItem.temp.min}°C, Max Temp: ${forecastItem.temp.max}°C'),
                            );
                          },
                        );
                      } else if (state is ForecastFailure) {
                        return Center(
                          child: Text('Failed forecast'),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else if (state is WeatherFailure) {
            return Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
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
