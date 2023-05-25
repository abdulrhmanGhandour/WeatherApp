import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double mintemp;
  double maxtemp;
  String weatherStatName;
  String icon;
  

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxtemp,
      required this.mintemp,
      required this.weatherStatName,
      required this.icon
      });

  factory WeatherModel.jsonFrom(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];

    return WeatherModel(
        date: DateTime.parse(data['location']['localtime']),
        temp: jsonData['avgtemp_c'],
        maxtemp: jsonData['maxtemp_c'],
        mintemp: jsonData['mintemp_c'],
        icon: jsonData['condition']['icon'] ,
        weatherStatName: jsonData['condition']['text']);
  }
  @override
  String toString() {
    return 'temp =$temp maxtem=$maxtemp mintemp = $mintemp date= $date';
  }

  String getImge() {
    if (weatherStatName == 'Clear' || weatherStatName == 'Light Cloud') {
      return 'assets/images/clear.png';
    } else if (weatherStatName == 'Sleet' ||
        weatherStatName == 'Snow' ||
        weatherStatName == 'Hail') {
      return 'assets/images/snow.png';
    } else if (weatherStatName == 'Heavy Cloud' ||
        weatherStatName == 'Partly cloudy' ||
        weatherStatName == 'Overcast') {
      return 'assets/images/cloudy.png';
    } else if (weatherStatName == 'Light Rain' ||
        weatherStatName == 'Heavy Rain' ||
        weatherStatName == 'Showers' ||
        weatherStatName == 'Patchy rain possible') {
      return 'assets/images/rainy.png';
    } else if (weatherStatName == 'Thunderstorm' ||
        weatherStatName == 'Thunder') {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  MaterialColor getThemeColor() {
    if (weatherStatName == 'Clear' || weatherStatName == 'Light Cloud') {
      return Colors.orange;
    } else if (weatherStatName == 'Sleet' ||
        weatherStatName == 'Snow' ||
        weatherStatName == 'Hail') {
      return Colors.blue;
    } else if (weatherStatName == 'Heavy Cloud' ||
        weatherStatName == 'Partly cloudy' ||
        weatherStatName == 'Overcast') {
      return Colors.blueGrey;
    } else if (weatherStatName == 'Light Rain' ||
        weatherStatName == 'Heavy Rain' ||
        weatherStatName == 'Showers' ||
        weatherStatName == 'Patchy rain possible') {
      return Colors.blue;
    } else if (weatherStatName == 'Thunderstorm' ||
        weatherStatName == 'Thunder') {
      return Colors.purple;
    } else {
      return Colors.orange;
    }
  }
}
