part of 'contacts_list_cubit.dart';

@immutable
abstract class ContactsListState {}

class LoadingContactsListState extends ContactsListState {}

class LoadedContactsListState extends ContactsListState {
  final List<Contact> contacts;
  LoadedContactsListState(this.contacts);
}

class InitContactsListState extends ContactsListState {}

class FatalErrorContactsListState extends ContactsListState {}
