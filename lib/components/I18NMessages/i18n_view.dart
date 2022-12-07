import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../error.dart';
import '../progress.dart';
import 'cubit/i18n_messages_cubit.dart';
import 'i18n_container.dart';

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator creator;
  const I18NLoadingView({super.key, required this.creator});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18nMessagesCubit, I18nMessagesState>(
        builder: (context, state) {
      if (state is InitI18nMessagesState || state is LoadingI18nMessagesState) {
        const ProgressView();
      }
      if (state is LoadedI18nMessagesState) {
        final messages = state.messages;

        return creator.call(messages);
      }
      return const ErrorView("erro ao buscar mensagens");
    });
  }
}
