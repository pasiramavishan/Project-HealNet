import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CommonMethods {
  checkConnectivity(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
      displaySnackBar("Your internet is not available!", context);
    }
  }

  displaySnackBar(String messageText, BuildContext context) {
    var snackBar = SnackBar(content: Text(messageText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
