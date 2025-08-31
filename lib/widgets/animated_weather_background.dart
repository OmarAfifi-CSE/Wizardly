import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_animation/weather_animation.dart';
import '../styling/weather_theme.dart';

class AnimatedWeatherBackground extends StatelessWidget {
  final WeatherTheme theme;

  const AnimatedWeatherBackground({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(theme.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        _buildWeatherAnimation(context),
      ],
    );
  }

  Widget _buildWeatherAnimation(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    switch (theme.weatherIcon) {
      case FontAwesomeIcons.sun:
        return SunWidget(sunConfig: SunConfig(width: screenSize.width * .5));

      case FontAwesomeIcons.cloud:
        return Stack(
          children: [
            CloudWidget(
              cloudConfig: CloudConfig(x: 20.w, y: 140.h, size: 150.w),
            ),
            CloudWidget(
              cloudConfig: CloudConfig(x: 100.w, y: 600.h, size: 150.w),
            ),
          ],
        );

      case FontAwesomeIcons.cloudRain:
        return RainWidget(
          rainConfig: RainConfig(
            areaXStart: 0,
            areaXEnd: screenSize.width,
            areaYStart: 100.h,
            areaYEnd: screenSize.height,
            fallCurve: Curves.linear,
            count: 50,
          ),
        );

      case FontAwesomeIcons.snowflake:
        return SnowWidget(
          snowConfig: SnowConfig(
            areaXStart: 0,
            areaXEnd: screenSize.width,
            areaYStart: 100.h,
            areaYEnd: screenSize.height,
            count: 100,
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
