import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import 'history_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    final history = Provider.of<HistoryProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text("Calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
          )
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [

            // ================= DISPLAY =================
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      calc.expression,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      calc.result,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ================= SCIENTIFIC =================
            Row(
              children: [
                sci(calc, "("),
                sci(calc, ")"),
                sci(calc, "π"),
                sci(calc, "e"),
              ],
            ),

            Row(
              children: [
                sci(calc, "sin"),
                sci(calc, "cos"),
                sci(calc, "tan"),
                sci(calc, "√"),
              ],
            ),

            Row(
              children: [
                sci(calc, "x²"),
                sci(calc, "^"),
                sci(calc, "%"),
                sci(calc, "/"),
              ],
            ),

            // ================= BASIC =================
            row(calc, history, ["C", "CE", "%", "/"]),
            row(calc, history, ["7", "8", "9", "*"]),
            row(calc, history, ["4", "5", "6", "-"]),
            row(calc, history, ["1", "2", "3", "+"]),
            row(calc, history, ["0", ".", "="]),
          ],
        ),
      ),
    );
  }

  // ================= ROW =================
  Widget row(
      CalculatorProvider calc,
      HistoryProvider history,
      List<String> items,
      ) {
    return Row(
      children: items.map((e) => button(calc, e, history)).toList(),
    );
  }

  // ================= BUTTON =================
  Widget button(
      CalculatorProvider calc,
      String text,
      HistoryProvider history,
      ) {
    final isOp = ["+", "-", "*", "/", "="].contains(text);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            isOp ? const Color(0xFF4ECDC4) : const Color(0xFF2C2C2C),
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            switch (text) {
              case "C":
                calc.clear();
                break;

              case "CE":
                calc.delete();
                break;

              case "=":
                calc.calculate(history);
                break;

              case "(":
              case ")":
              case "%":
              case "+":
              case "-":
              case "*":
              case "/":
                calc.input(text);
                break;

              default:
                calc.input(text);
            }
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // ================= SCI BUTTON =================
  Widget sci(CalculatorProvider calc, String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () {
            switch (text) {
              case "π":
                calc.input("π");
                break;

              case "e":
                calc.input("e");
                break;

              case "√":
                calc.input("sqrt(");
                break;

              case "sin":
              case "cos":
              case "tan":
                calc.input("$text(");
                break;

              case "(":
              case ")":
              case "x²":
              case "^":
                calc.input(text);
                break;

              default:
                calc.input(text);
            }
          },
          child: Text(text),
        ),
      ),
    );
  }
}
