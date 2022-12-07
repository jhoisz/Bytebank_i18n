import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/I18NMessages/i18n_container.dart';
import '../../components/container.dart';
import '../../models/name.dart';
import 'dashboard.dart';
import 'dashboard_i18n.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NameCubit("Jhois"),
        child: I18NLoadingContainer(
            viewKey: "dashboard",
            creator: (messages) =>
                DashboardView(i18n: DashboardViewLazyI18N(messages)))
        // child: BlocBuilder<NameCubit, String>(
        //   builder: (context, state) => const DashboardView(),
        // ),
        );
  }
}
