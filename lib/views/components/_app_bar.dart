import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/budget_bloc.dart';
import '../../routes.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  final int pageId;
  const MyAppBar({super.key, required this.title, required this.pageId});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
      actions: [
        BlocBuilder<BudgetBloc, BudgetState>(
          builder: (context, state) {
            if (state is BudgetSuccess) {
              if (state.budgets.isNotEmpty) {
                return InkWell(
                  onTap: () {
                    if (widget.pageId != 1) {
                      Navigator.pushNamed(context, Routes.history);
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${state.budgets.length}",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return Container();
          },
        ),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.account_box_rounded)),
      ],
    );
  }
}
