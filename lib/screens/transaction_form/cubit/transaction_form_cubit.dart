import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../http/webclients/transaction_webclient.dart';
import '../../../models/transaction.dart';

part 'transaction_form_state.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(ShowFormState());
  final TransactionWebClient _webClient = TransactionWebClient();

  void save(Transaction transactionCreated, String password,
      BuildContext context) async {
    emit(SendingState());

    Transaction? transaction =
        await _send(transactionCreated, password, context);

    if (transaction != null) {
      emit(SentState());
    }
  }

  Future<Transaction?> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    await _webClient
        .save(transactionCreated, password)
        .then((transaction) => emit(SentState()))
        .catchError((e) {
      emit(FatalErrorTransactionFormState(e.message));
    }, test: (e) => e is HttpException).catchError((e) {
      emit(
          FatalErrorTransactionFormState('timeout submitting the transaction'));
    }, test: (e) => e is TimeoutException).catchError((e) {
      emit(FatalErrorTransactionFormState(e.message));
    });
    return null;
  }
}
