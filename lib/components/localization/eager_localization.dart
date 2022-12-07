import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/localization_cubit.dart';

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
