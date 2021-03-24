import 'package:weather_app/screens/city_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_icons/weather_icons.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final WeatherModel locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var cityName;
  var temperature;
  var condition;
  var conditionId;
  var humidity;
  var wind;
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(WeatherModel weatherData) {
    setState(() {
      cityName = weatherData.name;
      temperature = weatherData.main['temp'];
      Map<String, Object> cnd = weatherData.weather[0];
      conditionId = cnd['id'];
      condition = cnd['description'];
      humidity = weatherData.main['humidity'];
      wind = weatherData.wind['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final wData = WeatherModel();
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_home.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.multiply),
          ),
        ),
        padding: EdgeInsets.only(left: 30.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () async {
                      var weatherData = await wData.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me_outlined,
                      size: 30.0,
                      color: Colors.white,
                    )),
                TextButton(
                  onPressed: () async {
                    var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ));
                    if (typedName != null) {
                      var weatherData = await wData.getCityWeather(typedName);
                      updateUi(weatherData);
                    }
                  },
                  child: Icon(
                    Icons.location_city,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cityName,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Spartan MB',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${date.year} / ${date.month} / ${date.day} : ${date.hour} : ${date.minute}',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Spartan MB',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25.0, bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${temperature.toStringAsFixed(0)}°',
                    style: kTempTextStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        '${wData.getWeatherIcon(conditionId)}',
                        style: TextStyle(fontSize: 40.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '$condition',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                    child: Divider(
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(' Wind '),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('$wind'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('km/h'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(' Humidity '),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('$humidity'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(' % '),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
