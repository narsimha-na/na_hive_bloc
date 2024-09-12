import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:na_hive_bloc/data/boxes.dart';
import 'package:na_hive_bloc/models/transactions.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  CrudBloc() : super(const CrudInitial()) {
    Box<Transaction> boxTransaction;
    List<Transaction> transactions;
    Transaction? transaction;

    on<FetchAllData>((event, emit) {
      try {
        boxTransaction = Boxes.getTransaction();
        transactions = boxTransaction.values.toList();
        emit(DisplayAllDates(transactions: transactions));
      } catch (e) {
        log("Somthing went wrng : ${e.toString()}");
      }
    });

    on<AddData>((event, emit) {
      try {
        final box = Boxes.getTransaction();
        box.add(event.transaction);
        add(const FetchAllData());
      } catch (e) {
        print(e);
      }
    });

    on<UpdateSpecificData>((event, emit) {
      try {
        transaction = event.transaction;
        transaction!.name = event.name;
        transaction!.amount = event.amount;
        transaction!.isExpense = event.isExpense;
        transaction!.save();
        add(const FetchAllData());
      } catch (e) {
        print(e);
      }
    });
    on<DeleteData>((event, emit) {
      try {
        event.transaction.delete();
        add(const FetchAllData());
      } catch (e) {
        log("somthing went wrng : ${e.toString()}");
      }
    });
  }
}
