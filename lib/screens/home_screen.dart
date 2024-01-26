import 'package:flutter/material.dart';
import 'package:havapp/models/weather_model.dart';
import 'package:havapp/services/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:havapp/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherService("87f2c97815e71eae24a9578efdaf6134");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/sunny.json";

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloud.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rain.json";
      case "thunderstorm":
        return "assets/thunder.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final String cityName = _weather?.cityName ?? "Şehir yükleniyor...";
    final String condition = _weather?.mainCondition ?? "";

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cityName,
            ),
            Lottie.asset(getWeatherAnimation(condition)),
            Text(
              "${_weather?.temperature.round()} °C",
              style: const TextStyle(
                fontSize: temperatureFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
