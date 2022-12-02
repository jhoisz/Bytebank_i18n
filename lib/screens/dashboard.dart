import 'package:bytebank2/screens/name.dart';
import 'package:bytebank2/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/container.dart';
import '../components/localization/localization.dart';
import '../models/name.dart';
import 'contacts_list/contacts_list.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Jhois"),
      child: const DashboardView(),
      // child: BlocBuilder<NameCubit, String>(
      //   builder: (context, state) => const DashboardView(),
      // ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var i18n = DashboardViewI18N(context);

    final name = context.watch<NameCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $name'),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('images/bytebank_logo.png'),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FeatureItem(
                  name: i18n.transfer,
                  icon: Icons.monetization_on,
                  onClick: () => _showContactsList(context),
                ),
                _FeatureItem(
                  name: i18n.transactionFeed,
                  icon: Icons.description,
                  onClick: () => _showTransactionsList(context),
                ),
                _FeatureItem(
                  name: i18n.changeName,
                  icon: Icons.person_outline,
                  onClick: () => _showChangeName(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get transfer =>
      localize({
        "pt-br": "Transferir",
        "en": "Transfer",
      }) ??
      "Transfer";

  String get transactionFeed =>
      localize({
        "pt-br": "Transações",
        "en": "Transaction Feed",
      }) ??
      "Transaction Feed";

  String get changeName =>
      localize({
        "pt-br": "Mudar nome",
        "en": "Change name",
      }) ??
      "Change name";
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showContactsList(BuildContext context) {
  push(context, ContactsListContainer());
}

void _showTransactionsList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}

void _showChangeName(BuildContext blocContext) {
  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: const NameContainer(),
      ),
    ),
  );
}
