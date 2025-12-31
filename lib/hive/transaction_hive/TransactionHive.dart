import 'package:hive/hive.dart';

import '../../model/transaction/Transaction.dart';

class TransactionHive {

  Future<Box<Transaction>> getTransactionForCategory(int catId) async {
    final boxName = 'transaction_category_$catId';
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<Transaction>(boxName);
    }
    return Hive.box<Transaction>(boxName);
  }

  Future<List<Transaction>> getAllTransactions(int catId) async {
    final box = await getTransactionForCategory(catId);
    return box.values.toList();
  }

  Future<void> addTransaction(double amount, String description, DateTime date, int categoryId)async {
    var newTransact = Transaction(
      currentSpentAmount: amount,
      description: description,
      date: date,
      categoryId: categoryId,
    );
    final transactionsBox = await getTransactionForCategory(categoryId);
    await transactionsBox.add(newTransact);
  }

  Future<void> updateTransaction(int index, Transaction transact)async{
    final transactionsBox = await getTransactionForCategory(transact.categoryId);
    await transactionsBox.putAt(index, transact);
  }

  Future<void> deleteTransaction(int index, int catId)async{
    final transactionsBox = await getTransactionForCategory(catId);
    await transactionsBox.deleteAt(index);
  }
}
