import 'package:flutter/material.dart';

import '../../components/I18NMessages/cubit/i18n_messages_cubit.dart';
import '../../components/localization/eager_localization.dart';

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

class DashboardViewLazyI18N {
  final I18NMessages messages;
  DashboardViewLazyI18N(this.messages);

  String? get transfer => messages.get("transfer");

  String? get transactionFeed => messages.get("transaction_feed");

  String? get changeName => messages.get("change_name");
}
