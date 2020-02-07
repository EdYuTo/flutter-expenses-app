import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: index));
      double sum = 0;

      for (var i = 0; i < transactions.length; i++)
        if (transactions[i].date.day == day.day &&
            transactions[i].date.month == day.month &&
            transactions[i].date.year == day.year)
          sum += transactions[i].amount;

      return {'day': DateFormat.E().format(day).substring(0, 1), 'amount': sum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((infoDay) {
            return Expanded(
                child: ChartBar(
              infoDay['day'],
              infoDay['amount'],
              totalSpending > 0
                  ? (infoDay['amount'] as double) / totalSpending
                  : 0,
            ));
          }).toList(),
        ),
      ),
    );
  }
}
