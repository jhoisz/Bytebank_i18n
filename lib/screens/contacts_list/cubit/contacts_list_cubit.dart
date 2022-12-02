import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../database/dao/contact_dao.dart';
import '../../../models/contact.dart';
part 'contacts_list_state.dart';

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(InitContactsListState());

  void reload(ContactDao dao) {
    emit(LoadingContactsListState());
    dao.findAll().then((contacts) => emit(LoadedContactsListState(contacts)));
  }
}
