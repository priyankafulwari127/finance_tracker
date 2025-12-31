import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_green/hive/transaction_hive/TransactionHive.dart';
import 'package:go_green/model/category/Category.dart';
import 'package:go_green/model/transaction/Transaction.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  var transactionList = <Transaction>[].obs;
  var monthlyTransactionList = <Transaction>[].obs;
  TransactionHive transactionHive = TransactionHive();
  var selectedMonth = DateTime.now().obs;
  var selectedDate;
  TextEditingController dateController = TextEditingController();

  @override
  void onInit() {
    // getAllTransactions();
    filterTransactionListMonthly(selectedMonth.value);
    super.onInit();
  }

  Future<void> getAllTransactions(int catId) async {
    var transactionBox = await transactionHive.getAllTransactions(catId);
    transactionList.assignAll(transactionBox);
  }

  double getTotalWithCategoryId(int catId) {
    var total = 0.0;
    var currentMonth = DateTime.now().month;
    var currentYear = DateTime.now().year;
    for (var t in transactionList) {
      if (t.categoryId == catId && t.date.month == currentMonth && t.date.year == currentYear) {
        total += t.currentSpentAmount;
      }
    }
    return total;
  }

  Future<void> addTransaction(double amount, String description, DateTime date, int categoryId)async {
    transactionHive.addTransaction(amount, description, date, categoryId);
    var categoryBox = Hive.box<Category>('category');
    final category = categoryBox.values.firstWhere((c) => c.categoryId == categoryId);
    category.totalAmount += amount;
    await category.save();
  }

  // Future<void> updsate(int index, Category cat) async {
  //   categoryList[index] = cat;
  //   await categoryHive.updateCategory(cat, index);
  // }

  void deleteTransaction(int index, int catId) {
    transactionList.removeAt(index);
    transactionHive.deleteTransaction(index, catId);
  }

  List<Transaction> filterTransactionListMonthly(DateTime month, {int catId = 0}) {
    monthlyTransactionList.clear();
    for (var transaction in transactionList) {
      if (transaction.date.year == month.year && transaction.date.month == month.month && transaction.categoryId == catId || catId == 0) {
        monthlyTransactionList.add(transaction);
      }
    }
    //sorting the transaction list
    monthlyTransactionList.sort((a, b) => b.date.compareTo(a.date));

    return monthlyTransactionList;
  }

  void changeMonth(DateTime newMonth) {
    selectedMonth.value = newMonth;
    filterTransactionListMonthly(newMonth);
  }

  Future<void> selectDate(BuildContext context) async {
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
      // transaction.date = picker;
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    super.onClose();
  }
}
