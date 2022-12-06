import 'package:bytebank2/components/I18NMessages/cubit/i18n_messages_cubit.dart';
import 'package:bytebank2/components/error.dart';
import 'package:bytebank2/components/progress.dart';
import 'package:bytebank2/http/webclients/i18n_webclient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../container.dart';
import 'cubit/localization_cubit.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;
  const LocalizationContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: ((context) => CurrentLocaleCubit()),
      child: child,
    );
  }
}

class ViewI18N {
  String? language;
  ViewI18N(BuildContext context) {
    language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String? localize(Map<String, String> values) {
    // print("linguagem:  $language");
    // assert(values!=null);
    assert(values.containsKey(language));
    return values[language];
  }
}

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
        final cubit = I18nMessagesCubit();
        cubit.reload(I18NWebClient(viewKey: viewKey));
        return cubit;
      },
      child: I18NLoadingView(creator: creator),
    );
  }
}
