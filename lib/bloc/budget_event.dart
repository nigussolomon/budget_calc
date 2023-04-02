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

class ClearBudget extends BudgetEvent {
  const ClearBudget();

  @override
  List<Object> get props => [];
}

class DecItem extends BudgetEvent {
  final int index;
  const DecItem({required this.index});

  @override
  List<Object> get props => [];

  get data => index;
}

class IncItem extends BudgetEvent {
  final int index;
  const IncItem({required this.index});

  @override
  List<Object> get props => [];

  get data => index;
}

class DeleteItem extends BudgetEvent {
  final int index;
  const DeleteItem({required this.index});

  @override
  List<Object> get props => [];

  get data => index;
}

class RegisterUser extends BudgetEvent {
  final User user;
  const RegisterUser({required this.user});

  @override
  List<Object> get props => [];

  get data => user;
}
