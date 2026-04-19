import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/calculation_history.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> history = [];

  // ======================
  // LOAD HISTORY (KHI MỞ APP)
  // ======================
  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("history");

    if (data != null) {
      List decoded = jsonDecode(data);

      history = decoded
          .map((e) => CalculationHistory.fromJson(e))
          .toList();
    }

    notifyListeners();
  }

  // ======================
  // ADD HISTORY
  // ======================
  Future<void> addHistory(String expression, String result) async {
    history.insert(
      0,
      CalculationHistory(expression, result),
    );

    await _saveToLocal();
    notifyListeners();
  }

  // ======================
  // CLEAR HISTORY
  // ======================
  Future<void> clearHistory() async {
    history.clear();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove("history");

    notifyListeners();
  }

  // ======================
  // SAVE LOCAL STORAGE
  // ======================
  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();

    final data = history.map((e) => e.toJson()).toList();

    prefs.setString("history", jsonEncode(data));
  }
}
