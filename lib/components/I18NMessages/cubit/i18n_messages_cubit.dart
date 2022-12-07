import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';

import '../../../http/webclients/i18n_webclient.dart';

part 'i18n_messages_state.dart';

class I18nMessagesCubit extends Cubit<I18nMessagesState> {
  final LocalStorage storage = LocalStorage('local_unsecure_version_1.json');
  final String viewKey;

  I18nMessagesCubit(this.viewKey) : super(I18nMessagesInitial());

  void reload(I18NWebClient client) async {
    emit(LoadingI18nMessagesState());
    await storage.ready;

    final items = storage.getItem(viewKey);

    if (items != null) {
      emit(LoadedI18nMessagesState(
        I18NMessages(items),
      ));
      return;
    }

    client.findAll().then(saveAndRefresh);
  }

  FutureOr saveAndRefresh(Map<String, dynamic>? messages) {
    storage.setItem(viewKey, messages);

    print("saving $viewKey messages");

    final state = LoadedI18nMessagesState(I18NMessages(messages));
    emit(state);
  }
}
