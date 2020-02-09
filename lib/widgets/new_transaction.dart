import 'dart:io';

import 'package:expenses_app/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  State<StatefulWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        double.parse(_amountController.text) < 0 ||
        _selectedDate == null) return;
    widget._addNewTransaction(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      setState(() {
        _selectedDate = date;
        _submitData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                onSubmitted: (_) => _submitData(),
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen'
                            : DateFormat('dd/MM/yyyy').format(_selectedDate),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AdaptiveFlatButton("Choose date", _datePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
