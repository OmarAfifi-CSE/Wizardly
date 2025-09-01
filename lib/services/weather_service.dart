import 'package:dio/dio.dart';

class WeatherService {
  final String _apiKey = 'c3a96b9081eb41a983b182019252308';
  final String _baseUrl = "http://api.weatherapi.com/v1/forecast.json";
  final Dio _dio;

  WeatherService() : _dio = Dio();

  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'key': _apiKey, 'q': city, 'days': 7, 'aqi': 'no'},
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print(
          'Omar :: Error response: ${response.statusCode} - ${response.data}',
        );
        throw Exception('Failed to load weather data for $city');
      }
    } catch (e) {
      print('Omar :: Error: $e');
      throw Exception('Failed to connect to the weather service: $e');
    }
  }

  Future<Map<String, dynamic>> getWeatherByLocation(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'key': _apiKey,
          'q': '$lat,$lon',
          'days': 7,
          'aqi': 'no',
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print(
          'Omar :: Error response: ${response.statusCode} - ${response.data}',
        );
        throw Exception('Failed to load weather data for $lat,$lon');
      }
    } catch (e) {
      print('Omar :: Error: $e');
      throw Exception('Failed to connect to the weather service: $e');
    }
  }
}
