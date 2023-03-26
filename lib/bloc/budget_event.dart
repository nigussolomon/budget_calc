part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class FetchBudget extends BudgetEvent {
  const FetchBudget();

  @override
  List<Object> get props => [];
}

class AddBudget extends BudgetEvent {
  final Budget budget;
  const AddBudget({required this.budget});

  @override
  List<Object> get props => [];

  get data => budget;
}
