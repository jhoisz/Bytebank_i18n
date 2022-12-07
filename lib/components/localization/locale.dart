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
