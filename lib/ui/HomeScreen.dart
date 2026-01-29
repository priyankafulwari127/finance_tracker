import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_green/components/TextFields.dart';
import 'package:go_green/controller/categoryController/CategoryController.dart';
import 'package:go_green/controller/incomeController/IncomeController.dart';
import 'package:go_green/controller/transactionController/TransactionController.dart';
import 'package:go_green/model/IconList.dart';
import 'package:go_green/ui/ExpenseScreen.dart';

import '../functions/Functions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CategoryController categoryController = Get.put(CategoryController());
  IncomeController incomeController = Get.put(IncomeController());
  TransactionController transactionController = Get.put(TransactionController());
  var myFunctions = Functions();
  TextEditingController nameController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController inController = TextEditingController();
  var iconList = IconList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fintro",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _summaryTile("Monthly Income", incomeController.income.value),
                    _summaryTile("Monthly Expense", transactionController.monthlyExpense.value),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    myFunctions.addIncome(context, inController, 'Enter your income');
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.indigo,
                  ),
                  label: const Text(
                    "Add Income",
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    myFunctions.addCategory(context, nameController, budgetController, iconList);
                  },
                  icon: const Icon(
                    Icons.category,
                    color: Colors.indigo,
                  ),
                  label: const Text(
                    "Add Category",
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: categoryController.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = categoryController.categoryList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ExpenseScreen(
                            category: category,
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(category.getIconData()),
                          title: Text(category.categoryName),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                myFunctions.editCategory(context, index, category);
                              } else if (value == 'delete') {
                                categoryController.deleteCategory(index);
                                transactionController.getMonthlyExpense();
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryTile(String title, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "$value",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
