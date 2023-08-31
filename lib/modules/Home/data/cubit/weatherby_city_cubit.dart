import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/api/dio_consumer.dart';
import 'package:weather_app/core/api/end_points.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/modules/Home/models/five_forcast_model.dart';
import 'package:weather_app/modules/Home/models/weather_city_model.dart';

part 'weatherby_city_state.dart';

class WeatherbyCityCubit extends Cubit<WeatherbyCityState> {
  WeatherbyCityCubit() : super(WeatherbyCityInitial());

  final _dio = DioConsumer();

  Future<dynamic> getCityWeather({
    required String city,
  }) async {
    try {
      emit(WeatherbyCityLoading());
      Map<String, dynamic> queryParameter = {
        "q": city,
        "appid": Constants.apiKey,
        "units": "metric"
      };
      final response =
          await _dio.get(EndPoints.weather, queryParameters: queryParameter);
      final forecastResponse =
          await _dio.get(EndPoints.forecast, queryParameters: queryParameter);
      emit(WeatherbyCitySuccess(WeatherCityModel.fromJson(response),
          CityFiveForcastModel.fromJson(forecastResponse)));
      return response;
    } catch (e) {
      emit(WeatherbyCityFailed(e.toString()));
    }
  }
}
