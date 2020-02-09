import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _displayText;
  final Function _onClickButton;

  AdaptiveFlatButton(this._displayText, this._onClickButton);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _displayText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: _onClickButton,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              _displayText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: _onClickButton,
          );
  }
}
