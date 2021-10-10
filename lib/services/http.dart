import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/model.dart';

Future<Weather> getData() async {
  final response =
      await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=london&appid=f4e66b62cdbb2e9ba7eedc22fbfe6d3d'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> weatherData = data["weather"];
    return Weather.fromJson(weatherData);
  } else {
    throw Exception('Failed to create data.');
  }
}