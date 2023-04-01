import 'package:budget_calc/bloc/budget_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_calc/views/components/_app_bar.dart';
import 'package:intl/intl.dart';

import '../routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num totalPrice = 0;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(
      now.year,
      now.month,
      now.day,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: MyAppBar(
          title: widget.title,
          pageId: 0,
        ),
      ),
      drawer: Drawer(),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetInitial) {
            BlocProvider.of<BudgetBloc>(context).add(const FetchBudget());
          } else if (state is BudgetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BudgetSuccess) {
            void incQunatity() {
              totalPrice = 0;
              for (var budget in state.budgets) {
                totalPrice += budget.foodPrice * budget.quantity;
              }
            }

            incQunatity();
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.history);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        height: MediaQuery.of(context).size.height * .18,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nigus's Budget",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                DateFormat.MMMM().format(date),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Total Budget: ${totalPrice.toStringAsFixed(2)}\$",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3))),
                    height: MediaQuery.of(context).size.height * .65,
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final budget = state.items[index];
                        return Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                              image:
                                                  NetworkImage(budget.image))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .32,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        BlocProvider.of<BudgetBloc>(context)
                                            .add(AddBudget(budget: budget!));
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.shopping_cart)),
                                  Text("${budget.quantity}"),
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is BudgetFailed) {
            return const Center(
              child: Text("Failed to fetch!"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
