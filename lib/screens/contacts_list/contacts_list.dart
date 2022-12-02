import 'package:bytebank2/components/container.dart';
import 'package:bytebank2/components/progress.dart';
import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:bytebank2/screens/contact_form.dart';
import 'package:bytebank2/screens/transaction_form/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/contacts_list_cubit.dart';

class ContactsListContainer extends BlocContainer {
  ContactsListContainer({super.key});

  final ContactDao dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsListCubit>(
      create: (BuildContext context) {
        final cubit = ContactsListCubit();
        cubit.reload(dao);
        return cubit;
      },
      child: ContactsList(dao: dao),
    );
  }
}

class ContactsList extends StatefulWidget {
  final ContactDao dao;
  const ContactsList({Key? key, required this.dao}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
      ),
      floatingActionButton: buildAddContactButton(context),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
        builder: (context, state) {
          if (state is InitContactsListState ||
              state is LoadingContactsListState) {
            return const Progress();
          }
          if (state is LoadedContactsListState) {
            final contacts = state.contacts;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return _ContactItem(
                  contact: contact,
                  onClick: () {
                    push(context, TransactionFormContainer(contact));
                  },
                );
              },
              itemCount: contacts.length,
            );
          }

          return const Center(child: Text('Unknown error'));
        },
      ),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ContactForm(),
          ),
        );
        if (!mounted) return;
        update(context);
      },
      child: const Icon(Icons.add),
    );
  }

  void update(BuildContext context) {
    BlocProvider.of<ContactsListCubit>(context, listen: false)
        .reload(widget.dao);
    // context.watch<ContactsListCubit>().reload(widget.dao);
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function() onClick;

  const _ContactItem({
    required this.contact,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onClick,
        leading: const Icon(Icons.people),
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
