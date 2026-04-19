import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/calculator_provider.dart';
import 'providers/history_provider.dart';
import 'screens/calculator_screen.dart';
import 'providers/settings_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init history trước khi chạy app
  final historyProvider = HistoryProvider();
  await historyProvider.loadHistory();

  runApp(MyApp(historyProvider: historyProvider));
}

class MyApp extends StatelessWidget {
  final HistoryProvider historyProvider;

  const MyApp({super.key, required this.historyProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => historyProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const CalculatorScreen(),
      ),
    );
  }
}
