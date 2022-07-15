import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class NavigationUtils{

  Future pushPage(BuildContext context, Widget page){
    return Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return page;
        })
    );
  }

  pushReplacementPage(BuildContext context, Widget page){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return page;
        })
    );
  }

  pushAndRemovePage(BuildContext context, Widget page){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }),
        (route) => false
    );
  }

  void popUntilRoot(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

}