import 'package:get/get.dart';
import 'package:go_green/hive/transaction_hive/TransactionHive.dart';
import 'package:go_green/model/transaction/Transaction.dart';

class TransactionController extends GetxController {
  var transactionList = <Transaction>[].obs;
  var monthlyTransactionList = <Transaction>[].obs;
  TransactionHive transactionHive = TransactionHive();
  var selectedMonth = DateTime.now().obs;

  @override
  void onInit() {
    getAllTransactions();
    filterTransactionListMonthly(selectedMonth.value);
    super.onInit();
  }

  Future<void> getAllTransactions() async {
    transactionList.value = transactionHive.getAllTransactions();
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

  void addTransaction(double amount, String description, DateTime date, int categoryId) {
    var newTransact = Transaction(
      currentSpentAmount: amount,
      description: description,
      date: date,
      categoryId: categoryId,
    );
    transactionList.add(newTransact);
    transactionHive.addTransaction(amount, description, date, categoryId);
  }

  // Future<void> updsate(int index, Category cat) async {
  //   categoryList[index] = cat;
  //   await categoryHive.updateCategory(cat, index);
  // }

  void deleteTransaction(int index) {
    transactionList.removeAt(index);
    transactionHive.deleteTransaction(index);
  }

  List<Transaction> filterTransactionListMonthly(DateTime month, {int catId = 0}) {
    monthlyTransactionList.clear();
    for (var transaction in transactionList) {
      if (transaction.date.year == month.year && transaction.date.month == month.month) {
        monthlyTransactionList.add(transaction);
        print("category Id: $catId");
        print("current month: ${transaction.date.month}, ${transaction.date.year}");
      }
    }
    //sorting the transaction list
    monthlyTransactionList.sort((a, b) => b.date.compareTo(a.date));
    if (catId.isNull) {
      return monthlyTransactionList.where((t) => t.categoryId == catId).toList();
    }
    return [];
  }

  void changeMonth(DateTime newMonth) {
    selectedMonth.value = newMonth;
    filterTransactionListMonthly(newMonth);
  }
}
