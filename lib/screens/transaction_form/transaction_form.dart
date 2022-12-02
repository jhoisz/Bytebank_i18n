import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../components/container.dart';
import '../../components/progress.dart';
import '../../components/response_dialog.dart';
import '../../components/transaction_auth_dialog.dart';
import '../../models/contact.dart';
import '../../models/transaction.dart';
import 'cubit/transaction_form_cubit.dart';

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;
  const TransactionFormContainer(this._contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
        create: (buildContext) {
          return TransactionFormCubit();
        },
        child: BlocListener<TransactionFormCubit, TransactionFormState>(
          listener: (context, state) {
            if (state is SentState) {
              _showSuccessfullMessage(context);
            }
            if (state is FatalErrorTransactionFormState) {
              _showFailureMessage(context, state.message);
            }
          },
          child: TransactionForm(_contact),
        ));
  }
}

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  @override
  Widget build(BuildContext context) {
    // print('transaction form id $transactionId');

    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        builder: ((context, state) {
      if (state is ShowFormState) {
        return _BasicForm(contact: widget.contact);
      }
      if (state is SendingState || state is SentState) {
        return const ProgressView();
      }
      if (state is FatalErrorTransactionFormState) {
        return _BasicForm(contact: widget.contact);
      }

      return const Center(
        child: Text("Unknown error"),
      );
    }));
  }
}

class _BasicForm extends StatelessWidget {
  final Contact contact;
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();

  _BasicForm({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      // if (value != null) {
                      final transactionCreated =
                          Transaction(transactionId, value, contact);
                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionAuthDialog(
                            onConfirm: (String password) {
                              BlocProvider.of<TransactionFormCubit>(context)
                                  .save(transactionCreated, password, context);
                            },
                          );
                        },
                      );
                      // }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showSuccessfullMessage(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return const SuccessDialog('successful transaction');
    },
  );
}

void _showFailureMessage(
  BuildContext context,
  String? message,
) {
  showDialog(
    context: context,
    builder: (contextDialog) {
      return FailureDialog(message ?? 'Unknown Error');
    },
  );
}
