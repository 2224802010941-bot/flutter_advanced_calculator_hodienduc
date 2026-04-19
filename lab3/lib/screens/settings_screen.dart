import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../providers/history_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final history = Provider.of<HistoryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      backgroundColor: const Color(0xFF121212),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ======================
            // THEME
            // ======================
            SwitchListTile(
              title: const Text("Dark Mode",
                  style: TextStyle(color: Colors.white)),
              value: settings.settings.isDarkMode,
              onChanged: (_) => settings.toggleTheme(),
            ),

            // ======================
            // DEG / RAD
            // ======================
            SwitchListTile(
              title: const Text("Degree Mode (DEG/RAD)",
                  style: TextStyle(color: Colors.white)),
              value: settings.settings.isDegreeMode,
              onChanged: (_) => settings.toggleAngleMode(),
            ),

            // ======================
            // DECIMAL PRECISION
            // ======================
            const SizedBox(height: 20),
            const Text(
              "Decimal Precision",
              style: TextStyle(color: Colors.white),
            ),

            Slider(
              value: settings.settings.decimalPrecision.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              label: settings.settings.decimalPrecision.toString(),
              onChanged: (value) {
                settings.setDecimal(value.toInt());
              },
            ),

            const SizedBox(height: 20),

            // ======================
            // CLEAR HISTORY
            // ======================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                history.clearHistory();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("History cleared")),
                );
              },
              child: const Text("Clear History"),
            ),
          ],
        ),
      ),
    );
  }
}
