import 'package:weather_app/services/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});

  Uri url;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('${response.statusCode} status code');
    }
    final weatherData = WeatherModel.fromJson(jsonDecode(response.body));
    return weatherData;
  }
}
