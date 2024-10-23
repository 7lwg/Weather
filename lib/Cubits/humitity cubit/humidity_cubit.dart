// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'humidity_state.dart';

class HumidityCubit extends Cubit<HumidityState> {
  HumidityCubit() : super(HumidityInitial());

  void humidityCubit() {
    emit(HumidityInitial());
  }

  void sunCubit() {
    emit(Humidityscondry());
  }
}
