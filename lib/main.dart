import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_green/model/expense/Expense.dart';
import 'package:go_green/model/transaction/Transaction.dart';
import 'package:go_green/model/category/Category.dart';
import 'package:go_green/ui/HomeScreen.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(ExpenseAdapter());

  await Hive.openBox<Category>('category');
  await Hive.openBox<Transaction>('transaction');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}