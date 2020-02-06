import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';
import 'package:uuid/uuid.dart';


class UserTransactions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'Tenis', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Comida', amount: 15.99, date: DateTime.now()),
    Transaction(id: 't3', title: 'Drogas (remedio)', amount: 79.99, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTransaction = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: Uuid().v4(),
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ]
    );
  }
}