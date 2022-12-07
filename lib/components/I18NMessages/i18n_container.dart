import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../http/webclients/i18n_webclient.dart';
import 'cubit/i18n_messages_cubit.dart';
import '../container.dart';
import 'i18n_view.dart';

typedef I18NWidgetCreator = Widget Function(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreator creator;
  final String viewKey;

  const I18NLoadingContainer(
      {super.key, required this.viewKey, required this.creator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18nMessagesCubit>(
      create: (BuildContext context) {
        final cubit = I18nMessagesCubit(viewKey);
        cubit.reload(I18NWebClient(viewKey: viewKey));
        return cubit;
      },
      child: I18NLoadingView(creator: creator),
    );
  }
}
