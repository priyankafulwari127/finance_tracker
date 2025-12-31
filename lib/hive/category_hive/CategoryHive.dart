import 'package:go_green/model/transaction/Transaction.dart';
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
    var key = await categoryBox.add(newCat);
    newCat.categoryId = key;
    await newCat.save();

    var transactionBox = 'transaction_category_$key';
    await Hive.openBox<Transaction>(transactionBox);
  }

  Future<void> updateCategory(Category cat, int index) async {
    categoryBox.putAt(index, cat);
  }

  Future<void> deleteCategory(int index) async {
    categoryBox.deleteAt(index);
  }
}
