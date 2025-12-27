import 'package:hive/hive.dart';
part 'Expense.g.dart';

@HiveType(typeId: 1)
class Expense extends HiveObject {
  @HiveField(0)
  double? totalAmount;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  final int catId;


  Expense({this.date, this.totalAmount, this.description, required this.catId});
}
