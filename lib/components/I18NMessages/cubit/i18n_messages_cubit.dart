import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'i18n_messages_state.dart';

class I18nMessagesCubit extends Cubit<I18nMessagesState> {
  I18nMessagesCubit() : super(I18nMessagesInitial());

  void reload() {
    emit(LoadingI18nMessagesState());

    //TODO carregar
    emit(LoadedI18nMessagesState(
      I18NMessages({
        "transfer": "TRANSFER",
        "transaction_feed": "TRANSACTION FEED",
        "change_name": "CHANGE NAME"
      }),
    ));
  }
}
