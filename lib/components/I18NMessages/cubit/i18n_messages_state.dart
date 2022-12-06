part of 'i18n_messages_cubit.dart';

@immutable
abstract class I18nMessagesState {}

class I18nMessagesInitial extends I18nMessagesState {}

class LoadingI18nMessagesState extends I18nMessagesState {}

class LoadedI18nMessagesState extends I18nMessagesState {
  // final List<Contact> contacts;
  // LoadedContactsListState(this.contacts);
  final I18NMessages messages;

  LoadedI18nMessagesState(this.messages);
}

class I18NMessages {
  final Map<String, dynamic>? messages;

  I18NMessages(this.messages);

  String? get(String? key) {
    assert(key != null);
    if (messages != null) {
      assert(messages!.containsKey(key));
      return messages![key];
    }
    return null;
  }
}

class InitI18nMessagesState extends I18nMessagesState {}

class FatalErrorI18nMessagesState extends I18nMessagesState {}
