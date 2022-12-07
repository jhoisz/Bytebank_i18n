import 'package:bytebank2/screens/name.dart';
import 'package:bytebank2/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/container.dart';
import '../../models/name.dart';
import '../contacts_list/contacts_list.dart';
import 'dashboard_feature_item.dart';
import 'dashboard_i18n.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N i18n;
  const DashboardView({Key? key, required this.i18n}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                FeatureItem(
                  name: i18n.transfer ?? "",
                  icon: Icons.monetization_on,
                  onClick: () => _showContactsList(context),
                ),
                FeatureItem(
                  name: i18n.transactionFeed ?? "",
                  icon: Icons.description,
                  onClick: () => _showTransactionsList(context),
                ),
                FeatureItem(
                  name: i18n.changeName ?? "",
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
