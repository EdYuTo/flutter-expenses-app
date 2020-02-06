import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  State<StatefulWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _submitData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        double.parse(amountController.text) < 0) return;
    widget._addNewTransaction(
      titleController.text,
      double.parse(amountController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
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
