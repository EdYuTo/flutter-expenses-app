import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  //SystemChrome.setPreferredOrientations(
  //    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransactions = [
    Transaction(id: '01', title: '01', amount: 1, date: DateTime.now()),
    Transaction(id: '02', title: '02', amount: 1, date: DateTime.now()),
    Transaction(
        id: '03',
        title: '03',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: '04',
        title: '04',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: '05',
        title: '05',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: '06',
        title: '06',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: '07',
        title: '07',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: '08',
        title: '08',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: '09',
        title: '09',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: '10',
        title: '10',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: '11',
        title: '11',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        id: '12',
        title: '12',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        id: '13',
        title: '13',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(
        id: '14',
        title: '14',
        amount: 1,
        date: DateTime.now().subtract(Duration(days: 6))),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newTransaction = Transaction(
      title: txTitle,
      amount: txAmount,
      date: dateTime,
      id: Uuid().v4(),
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expenses App',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Expenses App',
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );

    final transactionList = Container(
      height: (_mediaQuery.size.height -
              _mediaQuery.padding.top -
              _appBar.preferredSize.height) *
          .7,
      child: TransactionList(_userTransactions, _removeTransaction),
    );

    final _pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show chart',
                  style: Theme.of(context).textTheme.title,
                ),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (!_isLandscape)
            Container(
              height: (_mediaQuery.size.height -
                      _mediaQuery.padding.top -
                      _appBar.preferredSize.height) *
                  .3,
              child: Chart(_recentTransactions),
            ),
          if (!_isLandscape) transactionList,
          if (_isLandscape)
            _showChart
                ? Container(
                    height: (_mediaQuery.size.height -
                            _mediaQuery.padding.top -
                            _appBar.preferredSize.height) *
                        .7,
                    child: Chart(_recentTransactions),
                  )
                : transactionList,
        ],
      ),
    );

    return SafeArea(
      child: Platform.isIOS
          ? CupertinoPageScaffold(
              navigationBar: _appBar,
              child: _pageBody,
            )
          : Scaffold(
              appBar: _appBar,
              body: _pageBody,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Platform.isIOS
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () => _startAddNewTransaction(context),
                      child: Icon(Icons.add),
                    ),
            ),
    );
  }
}
