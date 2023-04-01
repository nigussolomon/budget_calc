import 'package:budget_calc/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/budget_bloc.dart';
import 'components/_app_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.title});
  final String title;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: MyAppBar(
          title: widget.title,
          pageId: 1,
        ),
      ),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetSuccess) {
            return Container(
              margin: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * .9,
              child: ListView.builder(
                itemCount: state.budgets.length,
                itemBuilder: (BuildContext context, int index) {
                  final budget = state.budgets[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              width: 4,
                              color: const Color.fromARGB(28, 0, 0, 0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(50, 158, 158, 158),
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            //BoxShadow
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 11, vertical: 5),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(budget.image))),
                                height: MediaQuery.of(context).size.height * .1,
                                width: MediaQuery.of(context).size.width * .2,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(budget.foodTitle),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    margin: const EdgeInsets.only(top: 3),
                                    decoration: const BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Text(
                                      "${budget.foodPrice}\$",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add_circle)),
                                Text("${budget.quantity}"),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.remove_circle)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              if (state is BudgetSuccess) {
                print(state.totalPrice);
                return FloatingActionButton.extended(
                  elevation: 10,
                  onPressed: () {
                    BlocProvider.of<BudgetBloc>(context)
                        .add(const ClearBudget());
                    Navigator.pushReplacementNamed(context, Routes.home);
                  },
                  heroTag: "price",
                  backgroundColor: Colors.green,
                  label: Text(state.totalPrice.toStringAsFixed(2)),
                  icon: const Icon(Icons.money),
                );
              }
              return Container();
            },
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton.small(
            elevation: 10,
            onPressed: () {
              BlocProvider.of<BudgetBloc>(context).add(const ClearBudget());
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            heroTag: "save",
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          FloatingActionButton.small(
            elevation: 10,
            onPressed: () {
              BlocProvider.of<BudgetBloc>(context).add(const ClearBudget());
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            heroTag: "clear",
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
