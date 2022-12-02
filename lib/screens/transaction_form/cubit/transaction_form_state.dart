part of 'transaction_form_cubit.dart';

@immutable
abstract class TransactionFormState {}

class SendingState extends TransactionFormState {}

class SentState extends TransactionFormState {}

class ShowFormState extends TransactionFormState {}

class FatalErrorTransactionFormState extends TransactionFormState {
  final String message;
  FatalErrorTransactionFormState(this.message);
}
