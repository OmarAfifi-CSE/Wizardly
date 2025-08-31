import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wizardly/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherController extends ChangeNotifier {
  WeatherService weatherService = WeatherService();
  Weather? weather;
  String city = "Cairo";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> initWeather() async {
    _isLoading = true;
    notifyListeners();
    try {
      Position position = await _determinePosition();
      print('Omar :: Current position: $position');

      final weatherData = await weatherService.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      weather = Weather.fromJson(weatherData);
      city = weather!.cityName;
    } catch (e) {
      print('Omar :: Could not get current location: $e');
      try {
        print('Omar :: Trying to get last known location...');
        Position? lastPosition = await Geolocator.getLastKnownPosition();

        if (lastPosition != null) {
          final weatherData = await weatherService.getWeatherByLocation(
            lastPosition.latitude,
            lastPosition.longitude,
          );
          weather = Weather.fromJson(weatherData);
        } else {
          print('Omar :: No last known location found. Defaulting to Cairo.');
          await fetchWeatherByCity("Cairo");
        }
      } catch (fallbackError) {
        print(
          'Omar :: Error during fallback, defaulting to Cairo: $fallbackError',
        );
        await fetchWeatherByCity("Cairo");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCity(String city) async {
    _isLoading = true;
    notifyListeners();
    try {
      final weatherData = await weatherService.getWeatherByCity(city);
      weather = Weather.fromJson(weatherData);
      city = weather!.cityName;
    } catch (e) {
      print("Omar :: Error fetching weather data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateCity(String newCity) {
    city = newCity;
    fetchWeatherByCity(city);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> refreshWeather() async {
    try {
      final weatherData = await weatherService.getWeatherByCity(city);
      weather = Weather.fromJson(weatherData);
      notifyListeners();
    } catch (e) {
      print('Omar :: Failed to refresh weather: $e');
      notifyListeners();
    }
  }
}
