import 'package:math_expressions/math_expressions.dart';

class ExpressionParser {
  double evaluate(String expression) {
    try {
      String exp = expression;

      // ======================
      // 1. CLEAN INPUT
      // ======================
      exp = exp.replaceAll('×', '*');
      exp = exp.replaceAll('÷', '/');
      exp = exp.replaceAll('π', '3.1415926535');

      // ======================
      // 2. FIX √4 → sqrt(4)
      // ======================
      exp = exp.replaceAllMapped(
        RegExp(r'√(\d+(\.\d+)?)'),
            (match) => 'sqrt(${match.group(1)})',
      );

      // ======================
      // 3. AUTO FIX MISSING PARENTHESES
      // (QUAN TRỌNG)
      // ======================
      int open = '('.allMatches(exp).length;
      int close = ')'.allMatches(exp).length;

      if (open > close) {
        exp += ')' * (open - close);
      }

      // ======================
      // 4. PARSE
      // ======================
      Parser p = Parser();
      Expression expParsed = p.parse(exp);

      ContextModel cm = ContextModel();
      double result = expParsed.evaluate(EvaluationType.REAL, cm);

      return result;
    } catch (e) {
      throw Exception("Invalid Expression");
    }
  }
}
