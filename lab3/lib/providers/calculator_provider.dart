import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'history_provider.dart';

class CalculatorProvider extends ChangeNotifier {
  String expression = "";
  String result = "0";

  double memory = 0;
  bool isDegree = true; // DEG mode mặc định

  // =========================
  // INPUT
  // =========================
  void input(String value) {
    expression += value;
    notifyListeners();
  }

  void clear() {
    expression = "";
    result = "0";
    notifyListeners();
  }

  void delete() {
    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
    }
    notifyListeners();
  }

  // =========================
  // CONSTANTS
  // =========================
  void addConstant(String c) {
    if (c == "π") {
      expression += "3.1415926535";
    } else if (c == "e") {
      expression += "2.718281828";
    }
    notifyListeners();
  }

  void addFunction(String f) {
    if (f == "sqrt") {
      expression += "sqrt(";
    } else {
      expression += "$f(";
    }
    notifyListeners();
  }

  // =========================
  // DEG / RAD FIX
  // =========================
  double _degToRad(String value) {
    return double.parse(value) * 3.1415926535 / 180;
  }

  // =========================
  // CALCULATE (MAIN FIX)
  // =========================
  void calculate(HistoryProvider history) {
    try {
      String exp = expression;

      // FIX SYMBOLS
      exp = exp.replaceAll('×', '*');
      exp = exp.replaceAll('÷', '/');
      exp = exp.replaceAll(' ', '');
      exp = exp.replaceAll('°', '');

      // FIX SQRT
      exp = exp.replaceAllMapped(
        RegExp(r'sqrt\(([^)]+)\)'),
            (m) => 'sqrt(${m[1]})',
      );

      // =========================
      // DEGREE MODE FIX (sin cos tan)
      // =========================
      if (isDegree) {
        exp = exp.replaceAllMapped(
          RegExp(r'sin\(([^)]+)\)'),
              (m) => 'sin((${_degToRad(m[1]!).toString()}))',
        );

        exp = exp.replaceAllMapped(
          RegExp(r'cos\(([^)]+)\)'),
              (m) => 'cos((${_degToRad(m[1]!).toString()}))',
        );

        exp = exp.replaceAllMapped(
          RegExp(r'tan\(([^)]+)\)'),
              (m) => 'tan((${_degToRad(m[1]!).toString()}))',
        );
      }

      // =========================
      // PARSE EXPRESSION
      // =========================
      Parser p = Parser();
      Expression expParsed = p.parse(exp);
      ContextModel cm = ContextModel();

      double eval =
      expParsed.evaluate(EvaluationType.REAL, cm);

      result = eval.toString();

      // SAVE HISTORY
      history.addHistory(expression, result);
    } catch (e) {
      result = "Error";
    }

    notifyListeners();
  }

  // =========================
  // MEMORY FUNCTIONS
  // =========================
  void memoryClear() {
    memory = 0;
    notifyListeners();
  }

  void memoryAdd() {
    memory += double.tryParse(result) ?? 0;
    notifyListeners();
  }

  void memorySubtract() {
    memory -= double.tryParse(result) ?? 0;
    notifyListeners();
  }

  void memoryRecall() {
    expression += memory.toString();
    notifyListeners();
  }
}
