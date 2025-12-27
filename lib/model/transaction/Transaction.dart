import 'package:hive/hive.dart';
part 'Transaction.g.dart';

@HiveType(typeId: 2)
class Transaction extends HiveObject {
  @HiveField(0)
  double currentSpentAmount;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  int categoryId;

  Transaction({
    required this.currentSpentAmount,
    required this.description,
    required this.date,
    required this.categoryId,
  });
}
