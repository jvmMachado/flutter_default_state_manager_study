import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge_range.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../widgets/imc_gauge.dart';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  final weightEC = TextEditingController();
  final heightEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = ValueNotifier(0.0);

  @override
  void dispose() {
    weightEC.dispose();
    heightEC.dispose();
    super.dispose();
  }

  Future<void> _calculateImc(
      {required double weight, required double height}) async {
    imc.value = 0;

    await Future.delayed(const Duration(seconds: 1));

    imc.value = weight / pow(height, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC setState'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: imc,
                  builder: (_, imcValue, __) => ImcGauge(imc: imcValue),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: weightEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso é obrigatório';
                    }
                  },
                ),
                TextFormField(
                  controller: heightEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura é obrigatória';
                    }
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    var isFormValid = formKey.currentState?.validate() ?? false;

                    if (isFormValid) {
                      var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt-BR', decimalDigits: 2);

                      double weight = formatter.parse(weightEC.text) as double;
                      double height = formatter.parse(heightEC.text) as double;

                      _calculateImc(weight: weight, height: height);
                    }
                  },
                  child: const Text('Calcular IMC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
