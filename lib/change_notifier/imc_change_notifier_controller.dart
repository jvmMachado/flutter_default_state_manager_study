import 'dart:math';

import 'package:flutter/material.dart';

class ImcChangeNotifierController extends ChangeNotifier {
  var imc = 0.0;

  Future<void> calculateImc(
      {required double weight, required double height}) async {
    imc = 0;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    imc = weight / pow(height, 2);
    notifyListeners();
  }
}
