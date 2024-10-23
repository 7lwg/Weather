// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'delete_button_state.dart';

class DeleteButtonCubit extends Cubit<DeleteButtonState> {
  DeleteButtonCubit() : super(DeleteButtonInitial());

  // ignore: non_constant_identifier_names
  void delete_button() {
    emit(DeleteButtonInitial());
  }
}
