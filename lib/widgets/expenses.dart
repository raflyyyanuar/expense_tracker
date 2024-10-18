import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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
      category: Category.leisure,
    ),
    Expense(
      title: "Netflix",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Laptop",
      amount: 399.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Suitcase",
      amount: 54.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Oven",
      amount: 9.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void registerExpense(Expense newExpense) {
    setState(() {
      registeredExpenses.add(newExpense);
    });
  }

  void unregisterExpense(Expense newExpense) {
    setState(() {
      registeredExpenses.remove(newExpense);
    });
  }

  void openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onSubmit: registerExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter ExpenseTracker"),
        actions: [
          IconButton(
            onPressed: openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("The chart"),
          Expanded(
            child: ExpensesList(
              expenses: registeredExpenses,
              onDismissed: unregisterExpense,
            ),
          ),
        ],
      ),
    );
  }
}
