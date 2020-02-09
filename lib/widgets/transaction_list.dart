import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _removeTransaction;

  TransactionList(this._userTransactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
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
        : ListView.builder(
            itemBuilder: (context, index) {
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
                            'R\$${_userTransactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat('dd/MM/yyyy')
                        .format(_userTransactions[index].date),
                  ),
                  trailing: _mediaQuery.size.width > 360
                      ? FlatButton.icon(
                          onPressed: () =>
                              _removeTransaction(_userTransactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _removeTransaction(_userTransactions[index].id),
                        ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
