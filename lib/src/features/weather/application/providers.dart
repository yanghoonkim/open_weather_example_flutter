import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/weather_data.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

@riverpod
class City extends _$City {
  @override
  String build() {
    return 'London';
  }

  void setCity(String newCity) {
    state = newCity;
  }
}

@riverpod
Future<WeatherData> currentWeather(CurrentWeatherRef ref) async {
  final city = ref.watch(cityProvider);
  final weather =
      await ref.watch(weatherRepositoryProvider).getWeather(city: city);
  return WeatherData.from(weather);
}

@riverpod
Future<ForecastData> hourlyWeather(HourlyWeatherRef ref) async {
  final city = ref.watch(cityProvider);
  final forecast =
      await ref.watch(weatherRepositoryProvider).getForecast(city: city);
  return ForecastData.from(forecast);
}

/*
final hourlyWeatherProvider =
    FutureProvider.autoDispose<ForecastData>((ref) async {
  final city = ref.watch(cityProvider);
  final forecast =
      await ref.watch(weatherRepositoryProvider).getForecast(city: city);
  return ForecastData.from(forecast);
});
*/