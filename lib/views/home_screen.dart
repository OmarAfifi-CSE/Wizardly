import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wizardly/views/search_screen.dart';

import '../controllers/weather_controller.dart';
import '../models/weather_model.dart';
import '../styling/weather_theme.dart';
import '../widgets/animated_weather_background.dart';
import '../widgets/daily_forecast_tile.dart';
import '../widgets/glass_container.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/weather_detail_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _contentKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final weatherController = context.watch<WeatherController>();
    final weather = weatherController.weather;
    final WeatherTheme theme = WeatherTheme.getThemeForWeather(
      weather?.conditionCode,
      weather?.isDay,
    );

    return Scaffold(
      body: Stack(
        children: [
          AnimatedWeatherBackground(theme: theme),
          SafeArea(
            child: weatherController.isLoading
                ? _buildLoadingShimmer(theme)
                : weather == null
                ? _buildEmptyState(context, weatherController, theme)
                : RefreshIndicator(
                    color: theme.primaryTextColor,
                    backgroundColor: theme.containerColor,
                    onRefresh: () async {
                      await weatherController.refreshWeather();
                      setState(() {
                        _contentKey = UniqueKey();
                      });
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          key: _contentKey,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildSearchBar(context, weatherController, theme)
                                .animate()
                                .fade(duration: 500.ms)
                                .slideY(begin: -1, curve: Curves.easeOutCubic)
                                .shimmer(duration: 1500.ms),
                            SizedBox(height: 24.h),
                            _buildMainWeatherInfo(context, weather, theme)
                                .animate()
                                .fade(delay: 100.ms, duration: 500.ms)
                                .slideX(begin: -0.2, curve: Curves.easeOutCubic)
                                .shimmer(duration: 1500.ms),
                            SizedBox(height: 24.h),
                            _buildWeatherDetails(weather, theme)
                                .animate()
                                .fade(delay: 200.ms, duration: 500.ms)
                                .slideX(begin: -0.2, curve: Curves.easeOutCubic)
                                .shimmer(duration: 1500.ms),
                            SizedBox(height: 20.h),
                            _buildForecastSection(context, weather, theme)
                                .animate()
                                .fade(delay: 300.ms, duration: 500.ms)
                                .slideX(begin: -0.2, curve: Curves.easeOutCubic)
                                .shimmer(duration: 1500.ms),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer(WeatherTheme theme) {
    return Shimmer.fromColors(
      baseColor: theme.containerColor.withValues(alpha: 0.9),
      highlightColor: Colors.white70,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for Search Bar
              Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
              SizedBox(height: 24.h),
              // Placeholder for Main Weather Info
              Container(
                height: 270.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              SizedBox(height: 24.h),
              // Placeholder for Weather Details
              Container(
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              SizedBox(height: 20.h),
              // Placeholder for Forecast Section
              Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    WeatherController weatherController,
    WeatherTheme theme,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchBar(context, weatherController, theme),
          SizedBox(height: 20.h),
          Center(
            child: Text(
              'Please connect to the internet first!',
              style: TextStyle(color: theme.primaryTextColor, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    WeatherController weatherController,
    WeatherTheme theme,
  ) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
    );
    return GestureDetector(
      onTap: () async {
        final selectedCity = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SearchScreen(
                  weatherController: weatherController,
                  theme: theme,
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
        if (selectedCity != null && selectedCity is String) {
          weatherController.updateCity(selectedCity);
        }
      },
      child: AbsorbPointer(
        child: Hero(
          tag: 'search-bar',
          child: Material(
            type: MaterialType.transparency,
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => weatherController.updateCity(value),
              style: TextStyle(color: theme.primaryTextColor),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                hintText: 'Search for a city...',
                hintStyle: TextStyle(color: theme.primaryTextColor),
                filled: true,
                fillColor: theme.containerColor.withValues(alpha: 0.8),
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.primaryTextColor.withValues(alpha: 0.8),
                ),
                border: baseBorder,
                enabledBorder: baseBorder,
                disabledBorder: baseBorder,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              cursorColor: theme.primaryTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainWeatherInfo(
    BuildContext context,
    Weather weather,
    WeatherTheme theme,
  ) {
    return GlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      backgroundColor: theme.containerColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '${weather.cityName}, ${weather.country}',
                  style: TextStyle(
                    color: theme.primaryTextColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                weather.conditionCode == 1000 && weather.isDay == 1
                    ? Icons.wb_sunny
                    : theme.weatherIcon,
                color: theme.primaryTextColor,
                size: 80.sp,
              ),
              SizedBox(width: 16.w),
              Text(
                "${weather.temperature.round()}°",
                style: TextStyle(
                  color: theme.primaryTextColor,
                  fontSize: 90.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            weather.condition,
            style: TextStyle(
              color: theme.primaryTextColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(Weather weather, WeatherTheme theme) {
    return GlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      backgroundColor: theme.containerColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherDetailCard(
                icon: Icons.thermostat,
                iconColor: theme.primaryTextColor,
                label: 'Feels like',
                labelColor: theme.primaryTextColor,
                value: '${weather.feelsLike.round()}°',
                valueColor: theme.primaryTextColor,
              ),
              WeatherDetailCard(
                icon: Icons.water_drop,
                iconColor: theme.primaryTextColor,
                label: 'Humidity',
                labelColor: theme.primaryTextColor,
                value: '${weather.humidity.round()}%',
                valueColor: theme.primaryTextColor,
              ),
              WeatherDetailCard(
                icon: FontAwesomeIcons.wind,
                iconColor: theme.primaryTextColor,
                label: 'Wind',
                labelColor: theme.primaryTextColor,
                value: '${weather.windSpeed.round()} km/h',
                valueColor: theme.primaryTextColor,
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherDetailCard(
                icon: FontAwesomeIcons.gaugeHigh,
                iconColor: theme.primaryTextColor,
                label: 'Pressure',
                labelColor: theme.primaryTextColor,
                value: '${weather.pressure.round()} mb',
                valueColor: theme.primaryTextColor,
              ),
              WeatherDetailCard(
                icon: FontAwesomeIcons.solidEye,
                iconColor: theme.primaryTextColor,
                label: 'Visibility',
                labelColor: theme.primaryTextColor,
                value: '${weather.visibility.round()} km',
                valueColor: theme.primaryTextColor,
              ),
              WeatherDetailCard(
                icon: Icons.update,
                iconColor: theme.primaryTextColor,
                label: 'Last updated',
                labelColor: theme.primaryTextColor,
                value: weather.lastUpdatedFormatted,
                valueColor: theme.primaryTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(
    BuildContext context,
    Weather weather,
    WeatherTheme theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          backgroundColor: theme.containerColor,
          child: _buildHourlyForecast(weather, theme),
        ),
        SizedBox(height: 8.h),
        GlassContainer(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          backgroundColor: theme.containerColor,
          child: _buildDailyForecast(weather.dailyForecasts, theme),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast(Weather weather, WeatherTheme theme) {
    final int currentHour = int.parse(weather.localtime.substring(0, 2));
    // Get today's remaining hourly forecasts
    final List<HourlyForecast> upcomingToday = weather.hourlyForecasts.where((
      forecast,
    ) {
      final int forecastHour = int.parse(forecast.time.substring(0, 2));
      return forecastHour >= currentHour;
    }).toList();
    // Get all of tomorrow's hourly forecasts
    List<HourlyForecast> tomorrowForecasts = [];
    if (weather.dailyForecasts.length > 1) {
      tomorrowForecasts = weather.dailyForecasts[1].hourlyForecasts;
    }

    // Combine today's remaining hours with tomorrow's and take the first 24
    final List<HourlyForecast> displayList = [
      ...upcomingToday,
      ...tomorrowForecasts,
    ].take(24).toList();

    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: displayList.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final forecast = displayList[index];
          final bool isFirstItem = index == 0;
          return HourlyForecastCard(
            time: isFirstItem ? "Now" : forecast.time,
            iconUrl: forecast.iconUrl,
            temperature: '${forecast.temp.round()}°',
            backgroundColor: theme.containerColor,
            textColor: theme.primaryTextColor,
          );
        },
      ),
    );
  }

  Widget _buildDailyForecast(
    List<DailyForecast> forecasts,
    WeatherTheme theme,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecasts.length,
      itemBuilder: (context, index) {
        final forecast = forecasts[index];
        final date = DateTime.parse(forecast.day);
        final dayName = index == 0
            ? 'Today'
            : index == 1
            ? 'Tomorrow'
            : DateFormat('EEE').format(date);
        return DailyForecastTile(
          day: dayName,
          iconUrl: forecast.iconUrl,
          condition: forecast.condition,
          tempHigh: '${forecast.maxTemp.round()}°',
          tempLow: '${forecast.minTemp.round()}°',
          textColor: theme.primaryTextColor,
        );
      },
    );
  }
}
