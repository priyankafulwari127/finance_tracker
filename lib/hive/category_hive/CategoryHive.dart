import 'package:go_green/model/expense/Expense.dart';
import 'package:hive/hive.dart';
import 'package:go_green/model/category/Category.dart';

class CategoryHive {
  var categoryBox = Hive.box<Category>('category');

  List<Category> getAllCategories() {
    return categoryBox.values.toList();
  }

  Future<void> createCategory(
    String categoryName,
    int iconPoints,
    String fontFamily,
    String iconFontPackage,
    double categoryBudget,
  ) async {
    var newCat = Category(
      categoryName: categoryName,
      iconPoints: iconPoints,
      fontFamily: fontFamily,
      categoryBudget: categoryBudget,
      iconFontPackage: iconFontPackage,
    );
    var key = categoryBox.add(newCat);
    var expenseBoxName = 'expense_category_$key';
    await Hive.openBox<Expense>(expenseBoxName);
  }

  Future<void> updateCategory(Category cat, int index) async {
    categoryBox.putAt(index, cat);
  }

  Future<void> deleteCategory(int index) async {
    categoryBox.deleteAt(index);
  }
}
