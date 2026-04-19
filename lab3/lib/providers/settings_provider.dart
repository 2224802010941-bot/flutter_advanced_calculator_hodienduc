import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculator_settings.dart';

class SettingsProvider extends ChangeNotifier {
  CalculatorSettings settings = CalculatorSettings();

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("settings");

    if (data != null) {
      settings = CalculatorSettings.fromJson(jsonDecode(data));
    }

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    settings.isDarkMode = !settings.isDarkMode;
    await _save();
  }

  Future<void> toggleAngleMode() async {
    settings.isDegreeMode = !settings.isDegreeMode;
    await _save();
  }

  Future<void> setDecimal(int value) async {
    settings.decimalPrecision = value;
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("settings", jsonEncode(settings.toJson()));
    notifyListeners();
  }
}
