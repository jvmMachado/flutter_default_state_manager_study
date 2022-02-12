import 'dart:async';
import 'dart:math';

import 'package:flutter_default_state_manager/bloc_pattern/imc_state.dart';

class ImcBlocPatternController {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcState(imc: 0));
  Stream<ImcState> get imcOut => _imcStreamController.stream;

  Future<void> calculateImc(
      {required double weight, required double height}) async {
    _imcStreamController.add(ImcStateLoading());
    await Future.delayed(const Duration(seconds: 1));

    final imc = weight / pow(height, 2);

    _imcStreamController.add(ImcState(imc: imc));
  }

  void dispose() {
    _imcStreamController.close();
  }
}
