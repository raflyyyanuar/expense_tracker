import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    Expense(
      title: "Gym",
      amount: 14.99,
      date: DateTime.now(),
      category: Category.LEISURE,
    ),
    Expense(
      title: "Netflix",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.LEISURE,
    ),
    Expense(
      title: "Laptop",
      amount: 399.99,
      date: DateTime.now(),
      category: Category.WORK,
    ),
    Expense(
      title: "Suitcase",
      amount: 54.99,
      date: DateTime.now(),
      category: Category.TRAVEL,
    ),
    Expense(
      title: "Oven",
      amount: 9.99,
      date: DateTime.now(),
      category: Category.FOOD,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("The chart"),
          Expanded(
            child: ExpensesList(
              expenses: registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
