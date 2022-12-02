import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(this._message, {super.key});

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing...'),
      ),
      body: Text(_message),
    );
  }
}
