import 'package:go_green/model/category/Category.dart';
import 'package:go_green/model/expense/Expense.dart';
import 'package:hive/hive.dart';

class ExpenseHive{

  Box<Expense> getExpenseBoxForCategory(int categoryId) {
    final boxName = 'expense_category_$categoryId';
    return Hive.box<Expense>(boxName);
  }

  List<Expense> getAllExpenses(int catId){
    var expenseBox = getExpenseBoxForCategory(catId);
    return expenseBox.values.toList();
  }

  void addExpense(double totalAmount, String description, DateTime date, int catId){
    var expenseBox = getExpenseBoxForCategory(catId);
    var newExp = Expense(date: date, totalAmount: totalAmount, description: description, catId: catId,);
    expenseBox.add(newExp);
  }

  void updateExpense(int index, Expense exp, int catId){
    var expenseBox = getExpenseBoxForCategory(catId);
    expenseBox.putAt(index, exp);
  }

  void deleteExpense(int index, int catId){
    var expenseBox = getExpenseBoxForCategory(catId);
    expenseBox.deleteAt(index);
  }
}