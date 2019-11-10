import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherOverview extends StatelessWidget {
  final _WeatherProvider _weatherProvider = _WeatherProvider();

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder<Weather>(
        future: _weatherProvider.getCurrentWeather(),
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          if (snapshot.hasData) {
            return _WeatherContainer(weather: snapshot.data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
       )
    );
  }
}

class _WeatherProvider {
  Future<Weather> getCurrentWeather() async {
    final http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=Kharkiv&units=metric&APPID=1ea55013049215603ece3fee22806975');
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

class _WeatherContainer extends StatelessWidget {
  const _WeatherContainer({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${weather.locationName} - ${weather.temperature} °C',
                style: Theme.of(context).textTheme.display1,
                textAlign: TextAlign.center,
              ),
              Image.network(weather.iconUrl),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${weather.locationName} \n'
                ' ${weather.temperature} °C',
                style: Theme.of(context).textTheme.display1,
                textAlign: TextAlign.center,
              ),
              Image.network(weather.iconUrl),
            ],
          );
        }
      },
    );
  }
}
