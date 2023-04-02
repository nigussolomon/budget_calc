part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetSuccess extends BudgetState {
  final List budgets;
  final List items;
  final User user;

  const BudgetSuccess(
      {required this.budgets, required this.items, required this.user});
}

class BudgetFailed extends BudgetState {}
