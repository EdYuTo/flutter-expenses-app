import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final double spendAmount;
  final double spendPercentage;

  ChartBar(this.dayLabel, this.spendAmount, this.spendPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      context,
      constraint,
    ) {
      return Column(
        children: [
          Container(
            height: constraint.maxHeight * .15,
            child: FittedBox(
              child: Text(
                'R\$${spendAmount.toStringAsFixed(0)}',
              ),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * .05,
          ),
          Container(
            height: constraint.maxHeight * .6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: spendPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * .05,
          ),
          Container(
            height: constraint.maxHeight * .15,
            child: FittedBox(
              child: Text(dayLabel),
            ),
          ),
        ],
      );
    });
  }
}
