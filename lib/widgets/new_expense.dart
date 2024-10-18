import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSubmit});

  final void Function(Expense) onSubmit;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Category selectedCategory = Category.leisure;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate!;
    });
  }

  bool submitExpense() {
    final enteredTitle = titleController.text.trim();
    if (enteredTitle.isEmpty) {
      // title is empty
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid title!"),
          content: const Text("Title must not be empty."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return false;
    }
    final enteredAmount = double.tryParse(amountController.text);
    if (enteredAmount == null || enteredAmount <= 0) {
      // invalid amount
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid amount!"),
          content: const Text("Amount must be greater than zero."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return false;
    }

    final Expense newExpense = Expense(
      title: enteredTitle,
      amount: enteredAmount,
      date: selectedDate,
      category: selectedCategory,
    );
    widget.onSubmit(newExpense);
    return true;
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text("Add New Expense"),
          // Title
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              // Amount
              Expanded(
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat.yMd().format(selectedDate)),
                    IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                items: Category.values
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(
                          c.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCategory = value;
                    });
                  }
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final isSuccessful = submitExpense();
                  if (isSuccessful) {
                    Navigator.pop(context);
                  }
                  print(titleController.text);
                  print(amountController.text);
                },
                child: const Text("Submit"),
              )
            ],
          )
        ],
      ),
    );
  }
}
