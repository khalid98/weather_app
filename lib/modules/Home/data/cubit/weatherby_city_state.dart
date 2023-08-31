part of 'weatherby_city_cubit.dart';

abstract class WeatherbyCityState {}

class WeatherbyCityInitial extends WeatherbyCityState {}
class WeatherbyCityLoading extends WeatherbyCityState {
  @override
  List<Object> get props => [];
}

class WeatherbyCitySuccess extends WeatherbyCityState {
  final WeatherCityModel weatherCityModel;
  final CityFiveForcastModel cityFiveForcastModel;

   WeatherbyCitySuccess(this.weatherCityModel,this.cityFiveForcastModel);
}

class WeatherbyCityFailed extends WeatherbyCityState {
  final String error;

   WeatherbyCityFailed(this.error);
}