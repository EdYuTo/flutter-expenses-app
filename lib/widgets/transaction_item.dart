import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionItem extends StatelessWidget {
  final Transaction _userTransaction;
  final Function _removeTransaction;

  const TransactionItem(this._userTransaction, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                  'R\$${_userTransaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          _userTransaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy')
              .format(_userTransaction.date),
        ),
        trailing: _mediaQuery.size.width > 360
            ? FlatButton.icon(
          onPressed: () =>
              _removeTransaction(_userTransaction.id),
          icon: Icon(Icons.delete),
          label: Text('Delete'),
          textColor: Theme.of(context).errorColor,
        )
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () =>
              _removeTransaction(_userTransaction.id),
        ),
      ),
    );
  }
}