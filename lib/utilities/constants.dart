import 'package:flutter/material.dart';

const baseURL = 'api.openweathermap.org';
const path = 'data/2.5/weather';
const apiKey = <Your API Key>;

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 20.0,
);

const kInputTextStyle = TextStyle(color: Colors.black);
const kInputStyleDecorator = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(Icons.location_city_rounded),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
