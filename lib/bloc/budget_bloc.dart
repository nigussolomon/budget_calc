import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/model.dart';
import '../data/repository.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final _apiServiceProvider = ApiServiceProvider();
  List budgets = [];
  num totalPrice = 0;
  BudgetBloc() : super(BudgetInitial()) {
    on<FetchBudget>((event, emit) async {
      emit(BudgetLoading());
      try {
        final items = await _apiServiceProvider.fetchBudgets();
        emit(BudgetSuccess(
            items: items!, totalPrice: totalPrice, budgets: budgets));
      } catch (e) {
        emit(BudgetFailed());
      }
    });

    on<AddBudget>((event, emit) =>
        {budgets.add(event.data), event.data.itemAdded = true});
  }
}
