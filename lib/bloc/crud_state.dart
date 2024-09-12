part of 'crud_bloc.dart';

abstract class CrudState extends Equatable {
  const CrudState();

  @override
  List<Object> get props => [];
}

class CrudInitial extends CrudState {
  const CrudInitial();

  @override
  List<Object> get props => [];
}

class DisplayAllDates extends CrudState {
  final List<Transaction> transactions;
  const DisplayAllDates({required this.transactions});
  @override
  List<Object> get props => [transactions];
}

class DisplaySpecificData extends CrudState {
  final Transaction transactions;
  const DisplaySpecificData({required this.transactions});
  @override
  List<Object> get props => [transactions];
}
