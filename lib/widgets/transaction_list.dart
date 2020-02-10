import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _removeTransaction;

  TransactionList(this._userTransactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                children: [
                  Text(
                    'No transactions to display',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraint.maxHeight * .5,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.contain),
                  )
                ],
              );
            },
          )
        : ListView(
            children: _userTransactions
                .map(
                  (transaction) => TransactionItem(ValueKey(transaction.id),
                      transaction, _removeTransaction),
                )
                .toList(),
          );
  }
}
