part of 'get_weather_data_cubit.dart';

sealed class GetWeatherDataState {}

final class GetWeatherDataInitial extends GetWeatherDataState {}

final class GetWeatherDataLoading extends GetWeatherDataState {}

final class GetWeatherDataSuccess extends GetWeatherDataState {}

final class GetWeatherDataError extends GetWeatherDataState {
  late final String errorMessage;
  GetWeatherDataError(this.errorMessage);
  List<Object> get props => [errorMessage];
}
