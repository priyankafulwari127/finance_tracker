import 'package:hive/hive.dart';

import '../../model/transaction/Transaction.dart';

class TransactionHive {
  var transactionBox = Hive.box<Transaction>('transaction');

  List<Transaction> getAllTransactions(){
    return transactionBox.values.toList();
  }

  void addTransaction(double amount, String description, DateTime date, int categoryId) {
    var newTransact = Transaction(
      currentSpentAmount: amount,
      description: description,
      date: date,
      categoryId: categoryId,
    );
    transactionBox.add(newTransact);
  }

  void updateTransaction(int index, Transaction transact){
    transactionBox.putAt(index, transact);
  }

  void deleteTransaction(int index){
    transactionBox.deleteAt(index);
  }
}
