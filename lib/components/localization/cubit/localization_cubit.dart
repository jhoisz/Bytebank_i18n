import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'localization_state.dart';

// class LocalizationCubit extends Cubit<LocalizationState> {
//   LocalizationCubit() : super(LocalizationInitial());
// }

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("pt-br");
}
