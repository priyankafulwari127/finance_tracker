import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_green/controller/categoryController/CategoryController.dart';
import 'package:go_green/controller/transactionController/TransactionController.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatelessWidget {
  final double spentAmount;
  final String description;
  final String date;
  final int categoryId;

  const TransactionsScreen({
    super.key,
    required this.spentAmount,
    required this.description,
    required this.date,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    TransactionController transactionController = Get.put(TransactionController());
    CategoryController categoryController = Get.put(CategoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Row(
                children: [
                  Text(
                    '${DateFormat.MMMM().format(transactionController.selectedMonth.value)}, ${transactionController.selectedMonth.value.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  IconButton(
                    onPressed: () {
                      transactionController.changeMonth(
                        DateTime(transactionController.selectedMonth.value.year, transactionController.selectedMonth.value.month - 1),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    onPressed: () {
                      transactionController.changeMonth(
                        DateTime(transactionController.selectedMonth.value.year, transactionController.selectedMonth.value.month + 1),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(
                () {
                  var transactions = transactionController.filterTransactionListMonthly(
                    transactionController.selectedMonth.value,
                    catId: categoryId,
                  );
                  return transactions.isEmpty
                      ? const Text("No Transaction found")
                      : ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transactions.elementAt(index).description,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          transactions.elementAt(index).date.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Text(
                                      transactions.elementAt(index).currentSpentAmount.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
