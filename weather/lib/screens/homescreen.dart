import 'package:flutter/material.dart';
import 'package:weather/models/WeatherModels.dart';
import 'package:weather/models/service/weatherService.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city Name
            Text(_weather?.cityName ?? 'Getting Your Location..........'),
            //Tempreture
            _weather?.tempreture != null
                ? Text("${_weather?.tempreture.toString()}°C")
                : Text("")
          ],
        ),
      ),
    );
  }
}
