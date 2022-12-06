import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../http/webclients/i18n_webclient.dart';

part 'i18n_messages_state.dart';

class I18nMessagesCubit extends Cubit<I18nMessagesState> {
  I18nMessagesCubit() : super(I18nMessagesInitial());

  void reload(I18NWebClient client) {
    emit(LoadingI18nMessagesState());

    client.findAll().then((messages) {
      emit(LoadedI18nMessagesState(
        I18NMessages(messages),
      ));
    });
  }
}
