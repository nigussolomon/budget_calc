import 'package:budget_calc/routes.dart';
import 'package:budget_calc/views/history.dart';
import 'package:budget_calc/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/budget_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          Routes.home: (context) =>
              const MyHomePage(title: 'BUDGET CALCULATOR'),
          Routes.history: (context) =>
              const HistoryPage(title: "BUDGET HISTORY"),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
