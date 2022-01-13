import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/newmodel.dart';

Future<WeatherData> getData(String location) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=f4e66b62cdbb2e9ba7eedc22fbfe6d3d'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    //List<dynamic> weatherData = data["weather"];
    //Map<String, dynamic> sys = data["sys"];
    //Weather.fromJson(weatherData);
    //return Sys.fromJson(sys);
    return WeatherData.fromJson(data);
  } else {
    throw Exception('Failed to create data.');
  }
}
