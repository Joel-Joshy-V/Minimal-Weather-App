// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:minimal_weather_app/models/weather_model.dart';
// import 'package:minimal_weather_app/services/weather_services.dart';

// class WeatherPage extends StatefulWidget {
//   const WeatherPage({super.key});

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//   //api key
//   final _weatherService = WeatherServices('6403dda27f896ea2243a3261e5f3a045');
//   weather? _weather;
//   // fetch weather
//   _fetchWeather() async {
//     // get the current city
//     String cityName = await _weatherService.getCurrentCity();
//     // get weather for city
//     try {
//       final weather = await _weatherService.getWeather(cityName);
//       setState(() {
//         _weather = weather;
//       });
//     }

//     // any errors
//     catch (e) {
//       print(e);
//     }
//   }

//   // weather animation
//   String getWeatherAnimation(String? mainCondition) {
//     if (mainCondition == null) return 'assests/sunny.json';
//     switch (mainCondition.toLowerCase()) {
//       case 'clouds':
//       case 'mist':
//       case 'smoke':
//       case 'haze':
//       case 'dust':
//       case 'fog':
//         return 'assests/cloud.json';
//       case 'rain':
//       case 'drizzle':
//       case 'shower rain':
//         return 'assests/rainy.json';
//       case 'thunderstorm':
//         return 'assests/thunder.json';
//       case 'clear':
//         return 'assests/sunny.json';
//       default:
//         return 'assests/sunny.json';  
//     }
//   }

//   // init state
//   @override
//   void initState() {
//     super.initState();

//     // fetch weather on startup
//     _fetchWeather();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 20, 21, 21),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // city name
//             Text(_weather?.cityName ?? "loading city.."),

//             // animation
//             Lottie.asset(getWeatherAnimation(_weather?.maincondition)),

//             // tempeature
//             Text('${_weather?.temperature.round()}°C'),

//             // weather condition
//             Text('_weather?.mainCondition ?? ""'),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherServices('6403dda27f896ea2243a3261e5f3a045');
  weather? _weather;
  bool _isLoading = true;

  // Fetch weather
  _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Get the current city
      String cityName = await _weatherService.getCurrentCity();
      // Get weather for the city
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assests/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assests/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assests/rainy.json';
      case 'thunderstorm':
        return 'assests/thunder.json';
      case 'clear':
        return 'assests/sunny.json';
      default:
        return 'assests/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // City name
                  Text(
                    _weather?.cityName ?? "Loading city..",
                    style: TextStyle(color: Color.fromARGB(255, 228, 230, 231), fontSize: 24),
                  ),
                  // Animation
                  Lottie.asset(getWeatherAnimation(_weather?.maincondition)),
                  // Temperature
                  Text(
                    '${_weather?.temperature.round()}°C',
                    style: TextStyle(color: Colors.white, fontSize: 48),
                  ),
                  // Weather condition
                  Text(
                    _weather?.maincondition ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
      ),
    );
  }
}
