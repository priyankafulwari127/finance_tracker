import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'Category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  String categoryName;
  @HiveField(1)
  final int iconPoints;
  @HiveField(2)
  final String? fontFamily;
  @HiveField(3)
  String? iconFontPackage;
  @HiveField(4)
  double? categoryBudget;
  @HiveField(5)
  int? categoryId;
  @HiveField(6)
  double totalAmount = 0.0;

  Category({
    required this.categoryName,
    required this.iconPoints,
    required this.fontFamily,
    this.iconFontPackage,
    required this.categoryBudget,
    this.categoryId,
    this.totalAmount = 0.0,
  });

  IconData getIconData() {
    return IconData(iconPoints, fontFamily: fontFamily, fontPackage: iconFontPackage);
  }
}