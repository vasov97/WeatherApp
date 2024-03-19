import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/di/app_dependencies.dart';
import 'package:weather_app/pages/home_page.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: MultiProvider(
        providers: AppDependencies.of(context).providers,
        child: const HomePage(),
      ),
    );
  }
}
