import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction _userTransaction;
  final Function _removeTransaction;

  const TransactionItem(Key key, this._userTransaction, this._removeTransaction)
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const _colors = [Colors.red, Colors.blue, Colors.purple];
    _bgColor = _colors[Random.secure().nextInt(3)];
    super.initState();
  }

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
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${widget._userTransaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ),
        title: Text(
          widget._userTransaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(widget._userTransaction.date),
        ),
        trailing: _mediaQuery.size.width > 360
            ? FlatButton.icon(
                onPressed: () =>
                    widget._removeTransaction(widget._userTransaction.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget._removeTransaction(widget._userTransaction.id),
              ),
      ),
    );
  }
}
