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

  Category({
    required this.categoryName,
    required this.iconPoints,
    required this.fontFamily,
    this.iconFontPackage,
    required this.categoryBudget,
  });

  IconData getIconData() {
    return IconData(iconPoints, fontFamily: fontFamily, fontPackage: iconFontPackage);
  }
}