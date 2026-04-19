import 'package:flutter_test/flutter_test.dart';
import 'package:lab3/providers/calculator_provider.dart';
import 'package:lab3/providers/history_provider.dart';

class FakeHistoryProvider extends HistoryProvider {
  @override
  Future<void> addHistory(String a, String b) async {
    // ignore for test
  }
}

void main() {
  test('Calculator basic test', () {
    final calc = CalculatorProvider();

    calc.input("5");
    calc.input("+");
    calc.input("3");

    calc.calculate(FakeHistoryProvider());

    expect(calc.result, "8.0");
  });
}
