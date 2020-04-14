import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;
  final double airPressure;
  final double humidity;
  final double visibility;
  final double predictability;
  final String windDirectionCompass;
  final double windSpeed;
  final double windDirection;
  final String sunRise;
  final String sunSet;
  final String timezoneName;

  const Weather({
    this.condition,
    this.formattedCondition,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.locationId,
    this.created,
    this.lastUpdated,
    this.location,
    this.airPressure,
    this.humidity,
    this.visibility,
    this.predictability,
    this.windDirectionCompass,
    this.windSpeed,
    this.windDirection,
    this.sunRise,
    this.sunSet,
    this.timezoneName,
  });

  @override
  List<Object> get props => [
    condition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
    location,
    airPressure,
    humidity,
    visibility,
    predictability,
    windDirectionCompass,
    windSpeed,
    windDirection,
    sunRise,
    sunSet,
    timezoneName,
  ];

  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
      condition: _mapStringToWeatherCondition(
          consolidatedWeather['weather_state_abbr']),
      formattedCondition: consolidatedWeather['weather_state_name'],
      minTemp: consolidatedWeather['min_temp'] as double,
      temp: consolidatedWeather['the_temp'] as double,
      maxTemp: consolidatedWeather['max_temp'] as double,
      created: consolidatedWeather['created'],
      airPressure: consolidatedWeather['air_pressure'],
      humidity: consolidatedWeather['humidity'],
      visibility: consolidatedWeather['visibility'],
      predictability: consolidatedWeather['predictability'],
      windDirectionCompass: consolidatedWeather['wind_direction_compass'],
      windSpeed: consolidatedWeather['wind_speed'],
      windDirection: consolidatedWeather['wind_direction'],
      sunRise: json['sun_rise'],
      sunSet: json['sun_set'],
      timezoneName: json['timezone_name'],
      locationId: json['woeid'] as int,
      lastUpdated: DateTime.now(),
      location: json['title'],


    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}