part of 'expenses_cubit.dart';

@immutable
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class GetAllExpensesSuccessfully extends ExpensesState {}
