import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_hive_bloc/bloc/crud_bloc.dart';
import 'package:na_hive_bloc/models/transactions.dart';

class DetailsPage extends StatefulWidget {
  final Transaction transaction;

  const DetailsPage({required this.transaction, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  bool toggleSwitch = false;

  @override
  void initState() {
    super.initState();
    _name.text = widget.transaction.name.toString();
    _amount.text = widget.transaction.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Details Page',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 22, 24, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 0,
                  ),
                  _detailsTitle(
                    text: 'Fund Type',
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: _detailsText(
                      text: widget.transaction.isExpense ? 'Expense' : 'Income',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _detailsTitle(
                    text: 'Name',
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: _detailsText(
                      text: widget.transaction.name.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _detailsTitle(
                    text: 'Amount',
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: _detailsText(
                      text: widget.transaction.amount.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: const Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: _name,
                                      decoration:
                                          const InputDecoration(isDense: true),
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Amount',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: _amount,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                      ),
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    'Expense / Income',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                    value: toggleSwitch,
                                    onChanged: (val) {
                                      setState(() {
                                        toggleSwitch = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  style: customButtonStyle(),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                BlocBuilder<CrudBloc, CrudState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        double amount =
                                            double.parse(_amount.text);
                                        context.read<CrudBloc>().add(
                                              UpdateSpecificData(
                                                transaction: widget.transaction,
                                                name: _name.text,
                                                amount: amount,
                                                isExpense: toggleSwitch,
                                              ),
                                            );
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Update'),
                                    );
                                  },
                                ),
                              ],
                            );
                          });
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Update'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _detailsTitle({
    required String text,
  }) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _detailsText({
    required String text,
  }) {
    log("data : ${text.toString()}");
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  ButtonStyle customButtonStyle() => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      );
}
