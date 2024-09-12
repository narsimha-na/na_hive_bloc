import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_hive_bloc/bloc/crud_bloc.dart';
import 'package:na_hive_bloc/models/transactions.dart';
import 'package:na_hive_bloc/presentation/details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
    final TextEditingController _amount = TextEditingController();
    bool toggleSwitch = false;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 25,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              isDense: true,
                            ),
                            maxLines: 1,
                            controller: _name,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              isDense: true,
                            ),
                            maxLines: 1,
                            controller: _amount,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Expense / Income',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: toggleSwitch,
                          onChanged: (val) {
                            setState(
                              () {
                                toggleSwitch = val;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (_name.text.isNotEmpty &&
                              _amount.text.isNotEmpty) {
                            double amount = double.parse(_amount.text);
                            context.read<CrudBloc>().add(AddData(
                                transaction: Transaction()
                                  ..name = _name.text
                                  ..createDate = DateTime.now()
                                  ..amount = amount
                                  ..isExpense = toggleSwitch));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("added successfully")));
                            _name.clear();
                            _amount.clear();
                            toggleSwitch = false;
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("name and amount cannot be empty"),
                              ),
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                });
              });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TODO List'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<CrudBloc, CrudState>(builder: (context, state) {
          if (state is CrudInitial) {
            context.read<CrudBloc>().add(const FetchAllData());
          }
          if (state is DisplayAllDates) {
            if (state.transactions.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            log("Cliked on item : ${state.transactions[i]}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => DetailsPage(
                                        transaction: state.transactions[i],
                                      )),
                                ));
                          },
                          child: Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.only(
                              bottom: 16,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _customText(
                                              text: state.transactions[i]
                                                          .isExpense ==
                                                      true
                                                  ? "Expense"
                                                  : "Income",
                                            ),
                                            _customText(
                                              text: state.transactions[i].name +
                                                  "".toUpperCase(),
                                            ),
                                            _customText(
                                              text: state.transactions[i].amount
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          }
          return Center(
            child: Text(
              'empty'.toUpperCase(),
              style: const TextStyle(
                fontSize: 21,
              ),
            ),
          );
        }),
      ),
    );
  }

  _customText({required String text}) {
    return Text(
      text,
      softWrap: true,
      maxLines: 2,
      style: const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
