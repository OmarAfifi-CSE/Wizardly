import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'app_assets.dart';

class WeatherTheme {
  final String backgroundImage;
  final IconData? weatherIcon;
  final Color primaryTextColor;
  final Color containerColor;
  final Color? accentColor;

  const WeatherTheme({
    required this.backgroundImage,
    required this.weatherIcon,
    required this.primaryTextColor,
    required this.containerColor,
    this.accentColor,
  });

  static const WeatherTheme nightTheme = WeatherTheme(
    backgroundImage: AppAssets.nightBackground,
    weatherIcon: FontAwesomeIcons.solidMoon,
    primaryTextColor: Color(0xffcedfff),
    containerColor: Color(0xff253A74),
  );

  static const WeatherTheme sunnyTheme = WeatherTheme(
    backgroundImage: AppAssets.sunnyBackground,
    weatherIcon: FontAwesomeIcons.sun,
    primaryTextColor: Color(0xffbe8667),
    containerColor: Color(0xffFAE2BD),
  );

  static const WeatherTheme cloudyTheme = WeatherTheme(
    backgroundImage: AppAssets.cloudyBackground,
    weatherIcon: FontAwesomeIcons.cloud,
    primaryTextColor: Color(0xffc2ecff),
    containerColor: Color(0xff5A8BAB),
  );

  static const WeatherTheme rainyTheme = WeatherTheme(
    backgroundImage: AppAssets.rainyBackground,
    weatherIcon: FontAwesomeIcons.cloudRain,
    primaryTextColor: Color(0xffd8fff7),
    containerColor: Color(0xff7FC3AE),
  );

  static const WeatherTheme snowyTheme = WeatherTheme(
    backgroundImage: AppAssets.snowyBackground,
    weatherIcon: FontAwesomeIcons.snowflake,
    primaryTextColor: Color(0xfffefeff),
    containerColor: Color(0xffA7ACC4),
  );

  static WeatherTheme getThemeForWeather(int? code, int? isDay) {
    switch (code) {
      case 1000:
        if (isDay == 0) {
          return nightTheme;
        }
        return sunnyTheme;
      case 1003:
      case 1006:
      case 1009:
      case 1030:
      case 1135:
      case 1147:
        return cloudyTheme;
      case 1063:
      case 1069:
      case 1072:
      case 1087:
      case 1150:
      case 1153:
      case 1168:
      case 1171:
      case 1180:
      case 1183:
      case 1186:
      case 1189:
      case 1192:
      case 1195:
      case 1198:
      case 1201:
      case 1204:
      case 1207:
      case 1240:
      case 1243:
      case 1246:
      case 1249:
      case 1252:
      case 1273:
      case 1276:
        return rainyTheme;
      case 1066:
      case 1114:
      case 1117:
      case 1210:
      case 1213:
      case 1216:
      case 1219:
      case 1222:
      case 1225:
      case 1237:
      case 1255:
      case 1258:
      case 1261:
      case 1264:
      case 1279:
      case 1282:
        return snowyTheme;
      default:
        return sunnyTheme;
    }
  }
}
