import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_green/controller/categoryController/CategoryController.dart';
import 'package:go_green/controller/incomeController/IncomeController.dart';
import '../components/TextFields.dart';
import '../model/IconList.dart';
import '../model/category/Category.dart';
import '../ui/HomeScreen.dart';

class Functions {
  CategoryController categoryController = Get.put(CategoryController());
  IncomeController incomeController = Get.put(IncomeController());

  void editCategory(BuildContext context, int index, Category cat) {
    TextEditingController categoryNameController = TextEditingController(text: cat.categoryName);
    TextEditingController budgetController = TextEditingController(text: cat.categoryBudget.toString());

    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          shadowColor: Colors.grey,
          elevation: 4,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.34,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edit Category',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFields(categoryNameController, 'Enter category name'),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFields(budgetController, 'Enter budget amount'),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        double budgetAmount = double.tryParse(budgetController.text) ?? 0.0;
                        var updatedCategory = Category(
                          iconPoints: cat.iconPoints,
                          fontFamily: cat.fontFamily,
                          iconFontPackage: cat.iconFontPackage,
                          categoryName: categoryNameController.text,
                          categoryBudget: budgetAmount,
                        );
                        categoryController.updateCategory(index, updatedCategory);
                        Get.back();
                        Get.snackbar('Success', 'Category updated successfully');
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addCategory(
    BuildContext context,
    TextEditingController nmController,
    TextEditingController bdController,
    IconList iconList,
  ) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                shadowColor: Colors.grey,
                elevation: 4,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.66,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Category Name',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFields(nmController, 'Enter category name'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Category Icon',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 185,
                          width: MediaQuery.of(context).size.height,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                            ),
                            elevation: 5,
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  itemCount: iconList.icons.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    var icon = iconList.icons[index];
                                    return Obx(() {
                                      return GestureDetector(
                                        onTap: () {
                                          categoryController.selectedIndex.value = index;
                                          categoryController.selectedIcon = icon;
                                        },
                                        child: Card(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                12,
                                              ),
                                            ),
                                          ),
                                          color: categoryController.selectedIndex.value == index ? Colors.deepPurple[400] : Colors.grey[350],
                                          child: Icon(
                                            icon,
                                            color: categoryController.selectedIndex.value == index ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Set Budget',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFields(bdController, 'Enter monthly budget'),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    12,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (nmController.text.isEmpty) {
                                Get.snackbar('Error', 'Please enter name');
                              } else if (bdController.text.isEmpty) {
                                Get.snackbar('Error', 'Please enter budget');
                              } else {
                                double? budget = double.tryParse(bdController.text) ?? 0.0;
                                await categoryController.createCategory(
                                  nmController.text,
                                  categoryController.selectedIcon!.codePoint,
                                  categoryController.selectedIcon!.fontFamily!,
                                  categoryController.selectedIcon!.fontPackage!,
                                  budget,
                                );
                                Get.offAll(HomeScreen());
                                Get.snackbar("Success", "Category has been added");
                                nmController.clear();
                                bdController.clear();
                              }
                            },
                            child: const Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void addIncome(BuildContext context, TextEditingController inController, String hintText) {
    inController = TextEditingController(text: incomeController.income.value.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              shadowColor: Colors.grey,
              elevation: 4,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Income',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFields(inController, hintText),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (inController.text.isEmpty) {
                              Get.snackbar('Error', 'Please enter your income');
                            } else {
                              double income = double.tryParse(inController.text) ?? 0.0;
                              incomeController.saveIncome(income);
                              Get.back();
                              Get.snackbar("Success", "Income has been added");
                              inController.clear();
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
