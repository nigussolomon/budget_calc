import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/model.dart';
import '../data/repository.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final _apiServiceProvider = ApiServiceProvider();
  List budgets = [];
  BudgetBloc() : super(BudgetInitial()) {
    on<FetchBudget>((event, emit) async {
      emit(BudgetLoading());
      try {
        final items = await _apiServiceProvider.fetchBudgets();
        emit(BudgetSuccess(items: items!, budgets: budgets));
      } catch (e) {
        emit(BudgetFailed());
      }
    });

    on<AddBudget>((event, emit) {
      if (!budgets.contains(event.data)) {
        event.data.quantity++;
        budgets.add(event.data);
      } else {
        for (var budget in budgets) {
          if (budget.id == event.data.id) {
            budget.quantity++;
          }
        }
      }
    });

    on<ClearBudget>((event, emit) {
      for (var budget in budgets) {
        budget.quantity = 0;
      }
      budgets.clear();
    });

    on<DecItem>((event, emit) {
      if (budgets[event.data].quantity <= 1) {
        budgets[event.data].quantity--;
        budgets.removeAt(event.data);
      } else {
        budgets[event.data].quantity--;
      }
    });

    on<IncItem>((event, emit) {
      budgets[event.data].quantity++;
    });

    on<DeleteItem>((event, emit) {
      budgets[event.data].quantity = 0;
      budgets.removeAt(event.data);
    });
  }
}
