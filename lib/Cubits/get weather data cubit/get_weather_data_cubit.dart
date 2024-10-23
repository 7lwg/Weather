import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/Repository/get_weather_data_repo.dart';

part 'get_weather_data_state.dart';

class GetWeatherDataCubit extends Cubit<GetWeatherDataState> {
  GetWeatherDataCubit() : super(GetWeatherDataInitial());
  GetWeatherDataRepo weatherdataRepo = GetWeatherDataRepo();

  Future<void> getWeatherData() async {
    emit(GetWeatherDataLoading());

    try {
      await weatherdataRepo.GetWeatherData().then((value) {
        if (value != null) {
          emit(GetWeatherDataSuccess());
        } else {
          emit(GetWeatherDataError('Failed to fetch Companies Name\'s'));
        }
      });
    } catch (error) {
      emit(GetWeatherDataError('An error occurred'));
    }
  }
}
