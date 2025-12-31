import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_green/hive/category_hive/CategoryHive.dart';
import 'package:go_green/model/category/Category.dart';

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;
  CategoryHive categoryHive = CategoryHive();
  IconData? selectedIcon = CupertinoIcons.doc_text;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    getAllCategories();
    loadCategories();
    super.onInit();
  }

  Future<void> loadCategories() async {
    if (categoryHive.categoryBox.isEmpty) {
      var cat1 = Category(
        categoryName: 'Investment',
        iconPoints: Icons.monetization_on_outlined.codePoint,
        fontFamily: Icons.monetization_on_outlined.fontFamily,
        iconFontPackage: Icons.monetization_on_outlined.fontPackage,
        categoryBudget: 10000,
      );
      var key1 = await categoryHive.categoryBox.add(cat1);
      cat1.categoryId = key1;
      await cat1.save();

      var cat2 = Category(
        categoryName: 'Shopping',
        iconPoints: Icons.shopping_cart_outlined.codePoint,
        fontFamily: Icons.shopping_cart_outlined.fontFamily,
        iconFontPackage: Icons.shopping_cart_outlined.fontPackage,
        categoryBudget: 5000,
      );
      var key2 = await categoryHive.categoryBox.add(cat2);
      cat2.categoryId = key2;
      await cat2.save();

      var cat3 = Category(
        categoryName: 'Food',
        iconPoints: Icons.food_bank_outlined.codePoint,
        fontFamily: Icons.food_bank_outlined.fontFamily,
        iconFontPackage: Icons.food_bank_outlined.fontPackage,
        categoryBudget: 2000,
      );
      var key3 = await categoryHive.categoryBox.add(cat3);
      cat3.categoryId = key3;
      await cat3.save();

      var cat4 = Category(
        categoryName: 'Travel',
        iconPoints: Icons.travel_explore_outlined.codePoint,
        fontFamily: Icons.travel_explore_outlined.fontFamily,
        iconFontPackage: Icons.travel_explore_outlined.fontPackage,
        categoryBudget: 5000,
      );
      var key4 = await categoryHive.categoryBox.add(cat4);
      cat4.categoryId = key4;
      await cat4.save();
      categoryList.assignAll(categoryHive.getAllCategories());
    }
  }

  Future<void> getAllCategories() async {
    categoryList.value = categoryHive.getAllCategories();
  }

  Future<void> createCategory(
    String categoryName,
    int iconPoints,
    String fontFamily,
    String iconFontPackage,
    double categoryBudget,
  ) async {
    await categoryHive.createCategory(
      categoryName,
      iconPoints,
      fontFamily,
      iconFontPackage,
      categoryBudget,
    );
    categoryList.assignAll(categoryHive.getAllCategories());
  }

  Future<void> updateCategory(int index, Category cat) async {
    // categoryList[index] = cat;
    await categoryHive.updateCategory(cat, index);
    categoryList.assignAll(categoryHive.getAllCategories());
  }

  Future<void> deleteCategory(int index) async {
    // categoryList.removeAt(index);
    await categoryHive.deleteCategory(index);
    categoryList.assignAll(categoryHive.getAllCategories());
  }
}
