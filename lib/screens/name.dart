import 'package:bytebank2/components/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/name.dart';

class NameContainer extends BlocContainer {
  const NameContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends StatelessWidget {
  NameView({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.watch<NameCubit>().state;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Change name"),
        ),
        body: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Desired name: ",
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text;
                    context.read<NameCubit>().change(name);
                  },
                  child: const Text("change"),
                ),
              ),
            )
          ],
        ));
  }
}
