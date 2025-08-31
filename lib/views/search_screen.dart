import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wizardly/widgets/animated_weather_background.dart';
import 'package:wizardly/widgets/glass_container.dart';

import '../controllers/weather_controller.dart';
import '../styling/weather_theme.dart';

class SearchScreen extends StatefulWidget {
  final WeatherController weatherController;
  final WeatherTheme theme;

  const SearchScreen({
    super.key,
    required this.weatherController,
    required this.theme,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> topCitiesEgypt = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Suez',
    'Al Mansurah',
    'Zagazig',
    'Marsa Matruh',
  ];
  final List<String> topCitiesWorld = [
    'New York',
    'Paris',
    'London',
    'Tokyo',
    'Rome',
    'Dubai',
    'Moscow',
    'Sydney',
    'Singapore',
    'Beijing',
    'Athens',
  ];

  void _onCitySelected(String city) {
    if (city.isNotEmpty) {
      widget.weatherController.updateCity(city);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = widget.weatherController;
    final WeatherTheme theme = widget.theme;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedWeatherBackground(theme: theme),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(
                    context,
                    weatherController,
                    theme,
                  ).animate().shimmer(duration: 1000.ms),
                  SizedBox(height: 24.h),
                  GlassContainer(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        backgroundColor: theme.containerColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current city',
                              style: TextStyle(
                                color: theme.primaryTextColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Current city chip
                            ActionChip(
                              avatar: Icon(
                                Icons.location_on,
                                color: theme.primaryTextColor,
                                size: 18.sp,
                              ),
                              label: Text(
                                '${weatherController.weather?.cityName}',
                              ),
                              labelStyle: TextStyle(
                                color: theme.primaryTextColor,
                              ),
                              backgroundColor: theme.containerColor.withValues(
                                alpha: 0.8,
                              ),
                              side: BorderSide.none,
                              onPressed: () => _onCitySelected(
                                weatherController.weather?.cityName ?? '',
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideX(begin: 0.2, curve: Curves.easeOutCubic)
                      .shimmer(duration: 1500.ms),
                  SizedBox(height: 24.h),
                  GlassContainer(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        backgroundColor: theme.containerColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Top cities',
                              style: TextStyle(
                                color: theme.primaryTextColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.0.w,
                              runSpacing: 8.0.h,
                              children: topCitiesEgypt
                                  .map((city) => _buildCityChip(city, theme))
                                  .toList(),
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideX(begin: 0.2, curve: Curves.easeOutCubic)
                      .shimmer(duration: 1500.ms),
                  SizedBox(height: 24.h),
                  GlassContainer(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        backgroundColor: theme.containerColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Top cities - World',
                              style: TextStyle(
                                color: theme.primaryTextColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.0.w,
                              runSpacing: 8.0.h,
                              children: topCitiesWorld
                                  .map((city) => _buildCityChip(city, theme))
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideX(begin: 0.2, curve: Curves.easeOutCubic)
                      .shimmer(duration: 1500.ms),
                ],
              ),
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
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: 'search-bar',
            child: Material(
              type: MaterialType.transparency,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => _onCitySelected(value),
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
        SizedBox(width: 12.w),
        IconButton(
          padding: EdgeInsets.zero,
          icon: GlassContainer(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            borderRadius: 50.r,
            backgroundColor: theme.containerColor,
            child: Icon(Icons.close, color: theme.primaryTextColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildCityChip(String cityName, WeatherTheme theme) {
    return ActionChip(
      label: Text(cityName),
      labelStyle: TextStyle(
        color: theme.primaryTextColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: theme.containerColor.withValues(alpha: 0.8),
      shape: const StadiumBorder(),
      side: BorderSide.none,
      onPressed: () => _onCitySelected(cityName),
    );
  }
}
