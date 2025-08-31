import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wizardly/views/home_screen.dart';


import 'controllers/weather_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ChangeNotifierProvider(
        create: (_) => WeatherController()..initWeather(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wizardly',
          home: HomeScreen(),
        ),
      ),
    );
  }
}
