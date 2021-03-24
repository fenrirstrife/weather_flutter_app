import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/utilities/constants.dart';

class WeatherModel {
  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  Map<String, Object> coord;
  List<Object> weather;
  String base;
  Map<String, Object> main;
  Map<String, Object> wind;
  Map<String, Object> clouds;
  int dt;
  Map<String, Object> sys;
  int timezone;
  int id;
  String name;
  int cod;

  factory WeatherModel.fromJson(Map<String, Object> json) => WeatherModel(
        coord: json['coord'],
        weather: json['weather'],
        base: json['base'],
        main: json['main'],
        wind: json['wind'],
        clouds: json['clouds'],
        dt: json['dt'],
        sys: json['sys'],
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
      );

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper helper = NetworkHelper(
      url: Uri.https(
        '$baseURL',
        '$path',
        {
          'q': '$cityName',
          'appid': '$apiKey',
          'units': 'metric',
        },
      ),
    );
    var weatherData = await helper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    var location = Location();
    await location.getCurrentLocation();
    double lat = location.latitude;
    double long = location.longitude;
    NetworkHelper helper = NetworkHelper(
        url: Uri.https('$baseURL', '$path', {
      'lat': '$lat',
      'lon': '$long',
      'appid': '$apiKey',
      'units': 'metric',
    }));
    var weatherData = helper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
