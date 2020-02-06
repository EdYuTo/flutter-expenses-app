import 'package:flutter/material.dart';
import './user_transactions.dart';

class NewTransaction extends StatelessWidget {
  final Function _addNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this._addNewTransaction);

  void _submitData() {
    if (titleController.text.isEmpty || amountController.text.isEmpty || double.parse(amountController.text) < 0)
      return;
    _addNewTransaction(
        titleController.text,
        double.parse(amountController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child:  Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              onSubmitted: (_) => _submitData(),
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            FlatButton(
              child: Text('Add transaction'),
              textColor: Colors.purple,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}