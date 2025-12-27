import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_green/controller/transactionController/TransactionController.dart';
import 'package:go_green/hive/expense_hive/ExpenseHive.dart';
import 'package:go_green/model/expense/Expense.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController {
  var expenseList = <Expense>[].obs;
  ExpenseHive expenseHive = ExpenseHive();
  TextEditingController dateController = TextEditingController();
  TransactionController transactionController = TransactionController();
  var selectedDate;
  var categoryId;

  @override
  void onInit() {
    getExpenseDetails(categoryId);
    super.onInit();
  }

  Future<void> getExpenseDetails(int catId) async {
    categoryId = catId;
    expenseList.value = expenseHive.getAllExpenses(catId);
  }

  Future<void> getTotalWithCategoryId(Expense expense)async{
    expense.totalAmount = transactionController.getTotalWithCategoryId(expense.catId);
  }

  Future<void> createExpense(String description, double totalAmount, DateTime date, int catId) async {
    var newExpense = Expense(
      description: description,
      totalAmount: totalAmount,
      date: date, catId: catId,
    );
    expenseList.add(newExpense);
    expenseHive.addExpense(totalAmount, description, date, catId);
  }

  Future<void> selectDate(BuildContext context, Expense expense) async {
    final DateTime? picker = await showDatePicker(
      initialDate: selectedDate ?? DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if(picker != null && picker != selectedDate){
      var formattedDate = DateFormat('dd-MM-yyyy').format(picker);
      dateController.text = formattedDate;
      selectedDate = picker;
      expense.date = picker;
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    super.onClose();
  }
}
