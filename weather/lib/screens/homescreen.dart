import 'package:flutter/material.dart';
import 'package:weather/models/WeatherModels.dart';
import 'package:weather/models/service/weatherService.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //api Key
  final _WeatherService = WeatherService('307ee2a5f41af1b81435f71e52c9cc27');
  Weather? _weather;
  //fetch weather
  _fetchWeather() async {
    //Get the current city
    String cityName = await _WeatherService.getCurrentCity();
    //Get the weather for current city
    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getMainCondion(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/animations/animations/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'sunny':
        return 'assets/animations/animations/sunny.json';
      case 'rainy':
        return 'assets/animations/animations/Rainy.json';
      case 'clouds':
        return 'assets/animations/animations/cloudy.json';
      case 'thunder':
        return 'assets/animations/animations/thunder.json';
      default:
        return 'assets/animations/animations/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _weather == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Getting current weather',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Please Wait.....',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  //city Name
                  Text(
                    _weather?.cityName ?? 'Getting Your Location..........',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  //animations
                  SizedBox(
                      height: 450,
                      width: 300,
                      child: Lottie.asset(
                          getMainCondion(_weather?.mainCondition))),
                  //Tempreture
                  _weather?.tempreture != null
                      ? Text(
                          "${_weather?.tempreture.round()}°C",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        )
                      : const Text("Getting current tempreture..........."),
                  //Wether Condition
                  Text(
                      _weather?.mainCondition ??
                          'Getting Weather condition...............',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700))
                ],
              ),
            ),
    );
  }
}
