import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherServices {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = 'a9339df8a8a94e7581b113542230902';

  Future<WeatherModel?> getWeather({required String cityName}) async {

    WeatherModel? weather;
    try {
      Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName');
      http.Response response = await http.get(url);

      Map<String, dynamic> data = jsonDecode(response.body);

       weather = WeatherModel.jsonFrom(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
}
