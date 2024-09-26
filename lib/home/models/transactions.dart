import 'package:hive/hive.dart';
part 'transactions.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime createDate;
  @HiveField(2)
  late bool isExpense = true;
  @HiveField(3)
  late double amount;

  @override
  String toString() {
    return 'Transaction(name: $name, createDate: $createDate, isExpense: $isExpense, amount: $amount)';
  }
}
