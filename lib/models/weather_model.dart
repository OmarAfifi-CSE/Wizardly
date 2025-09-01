import 'package:timeago/timeago.dart' as timeago;

class HourlyForecast {
  final String time;
  final String iconUrl;
  final double temp;

  HourlyForecast({
    required this.time,
    required this.iconUrl,
    required this.temp,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: (json['time'] as String).substring(11),
      iconUrl: json['condition']['icon'],
      temp: (json['temp_c'] as num).toDouble(),
    );
  }
}

class DailyForecast {
  final String day;
  final String iconUrl;
  final String condition;
  final double maxTemp;
  final double minTemp;
  final List<HourlyForecast> hourlyForecasts;

  DailyForecast({
    required this.day,
    required this.iconUrl,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.hourlyForecasts,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    // Hourly forecasts for the day
    final hourlyData = json['hour'] as List;
    final List<HourlyForecast> hourly = hourlyData
        .map((hourJson) => HourlyForecast.fromJson(hourJson))
        .toList();

    return DailyForecast(
      day: json['date'],
      iconUrl: json['day']['condition']['icon'],
      condition: json['day']['condition']['text'],
      maxTemp: (json['day']['maxtemp_c'] as num).toDouble(),
      minTemp: (json['day']['mintemp_c'] as num).toDouble(),
      hourlyForecasts: hourly,
    );
  }
}

class Weather {
  final int lastUpdatedEpoch;
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final String condition;
  final int conditionCode;
  final int isDay;
  final String iconCode;
  final double windSpeed;
  final double humidity;
  final double pressure;
  final double visibility;
  final List<HourlyForecast> hourlyForecasts;
  final List<DailyForecast> dailyForecasts;

  Weather({
    required this.lastUpdatedEpoch,
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.conditionCode,
    required this.isDay,
    required this.iconCode,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.hourlyForecasts,
    required this.dailyForecasts,
  });

  String get lastUpdatedFormatted {
    final lastUpdatedDateTime = DateTime.fromMillisecondsSinceEpoch(lastUpdatedEpoch * 1000);
    return timeago.format(lastUpdatedDateTime, locale: 'en_short');
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    // Daily forecasts
    final forecastDaysJson = json['forecast']['forecastday'] as List;
    final List<DailyForecast> daily = forecastDaysJson
        .map((dayJson) => DailyForecast.fromJson(dayJson))
        .toList();

    return Weather(
      lastUpdatedEpoch: (json['current']['last_updated_epoch'] as num).toInt(),
      cityName: json['location']['name'],
      country: json['location']['country'],
      temperature: (json['current']['temp_c'] as num).toDouble(),
      feelsLike: (json['current']['feelslike_c'] as num).toDouble(),
      condition: json['current']['condition']['text'],
      conditionCode: (json['current']['condition']['code'] as num).toInt(),
      isDay: (json['current']['is_day'] as num).toInt(),
      iconCode: (json['current']['condition']['icon'] as String).replaceAll(
        '64x64',
        '128x128',
      ),
      windSpeed: (json['current']['wind_kph'] as num).toDouble(),
      humidity: (json['current']['humidity'] as num).toDouble(),
      pressure: (json['current']['pressure_mb'] as num).toDouble(),
      visibility: (json['current']['vis_km'] as num).toDouble(),
      dailyForecasts: daily,
      hourlyForecasts: daily.isNotEmpty ? daily[0].hourlyForecasts : [],
    );
  }
}
