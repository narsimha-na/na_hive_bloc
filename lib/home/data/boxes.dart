import 'package:hive/hive.dart';
import 'package:na_hive_bloc/home/models/transactions.dart';

class Boxes {
  static Box<Transaction> getTransaction() =>
      Hive.box<Transaction>('transactions');
}
