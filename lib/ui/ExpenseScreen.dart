import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_green/controller/transactionController/TransactionController.dart';
import 'package:go_green/model/transaction/Transaction.dart';
import 'package:go_green/ui/TransactionsScreen.dart';
import 'package:intl/intl.dart';

import '../model/category/Category.dart';

const Color kPrimary = Color(0xFF6C4CF1);
const Color kBackground = Color(0xFFF6F7FB);

class ExpenseScreen extends StatelessWidget {
  final Category category;

  ExpenseScreen({
    super.key,
    required this.category,
  });

  TransactionController transactionController = Get.put(TransactionController());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final int? catId = category.categoryId;
    if (catId != null) {
      transactionController.getAllTransactions(catId);
    }

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          category.categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            _summaryCard(),
            const SizedBox(height: 24),
            _inputSection(),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: _bottomButtons(),
    );
  }

  Widget _summaryCard() {
    final int? catId = category.categoryId;

    if (catId == null) {
      return const Column(
        children: [
          Text("Total Spent"),
          SizedBox(height: 6),
          Text("₹ 0", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      );
    }

    return Column(
      children: [
        const Text("Total Spent This Month"),
        const SizedBox(height: 8),
        Text(
          "₹ ${category.totalAmount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _inputSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("Amount"),
          _textField(
            controller: amountController,
            hint: "Enter spent amount",
            icon: Icons.currency_rupee,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              double amount = double.tryParse(value) ?? 0.0;
              double budget = category.categoryBudget ?? 0.0;
              if (budget != 0 && amount >= budget) {
                Get.snackbar(
                  "Budget Alert",
                  "Amount exceeds monthly budget",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
          ),
          const SizedBox(height: 18),
          _label("Description"),
          _textField(
            controller: descriptionController,
            hint: "Enter description",
            icon: Icons.notes,
          ),
          const SizedBox(height: 18),
          _label("Date"),
          _textField(
            controller: transactionController.dateController,
            hint: "DD-MM-YYYY",
            icon: Icons.calendar_month_rounded,
            readOnly: true,
            onTap: () {
              transactionController.selectDate(Get.context!);
            },
          ),
          const SizedBox(height: 18),
          _label("Monthly Budget"),
          _textField(
            controller: budgetController,
            hint: category.categoryBudget != 0 ? category.categoryBudget.toString() : "Enter monthly budget",
            icon: Icons.account_balance_wallet_outlined,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              category.categoryBudget = double.tryParse(value) ?? 0.0;
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                Get.to(
                  () => TransactionsScreen(
                    categoryId: category.categoryId!,
                  ),
                );
              },
              child: const Text(
                "Transactions",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                double enteredAmount = double.tryParse(amountController.text) ?? 0.0;
                var budget = category.categoryBudget ?? 0.0;
                final int catId = category.categoryId ?? 0;
                if (category.categoryId == null) {
                  Get.snackbar("Error", "Category ID missing!");
                  return;
                }

                if (enteredAmount == 0) {
                  Get.snackbar("Error", "Please enter amount");
                } else if (transactionController.dateController.text.isEmpty) {
                  Get.snackbar("Error", "Please select date");
                } else if (budget == 0) {
                  Get.snackbar("Error", "Please enter budget");
                } else if (enteredAmount >= budget) {
                  Get.snackbar("Error", "Spent amount is greater than budget");
                } else {
                  var date = DateFormat('dd-MM-yyyy').parse(transactionController.dateController.text);
                  transactionController.addTransaction(
                    enteredAmount,
                    descriptionController.text,
                    date,
                    catId,
                  );
                  // expenseController.getTotalWithCategoryId(expense);

                  Get.snackbar("Success", "Your spent is saved");
                  amountController.clear();
                  descriptionController.clear();
                  transactionController.dateController.clear();
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
