class CalculatorSettings {
  bool isDarkMode;
  bool isDegreeMode;
  int decimalPrecision;

  CalculatorSettings({
    this.isDarkMode = true,
    this.isDegreeMode = true,
    this.decimalPrecision = 2,
  });

  Map<String, dynamic> toJson() {
    return {
      "isDarkMode": isDarkMode,
      "isDegreeMode": isDegreeMode,
      "decimalPrecision": decimalPrecision,
    };
  }

  factory CalculatorSettings.fromJson(Map<String, dynamic> json) {
    return CalculatorSettings(
      isDarkMode: json["isDarkMode"] ?? true,
      isDegreeMode: json["isDegreeMode"] ?? true,
      decimalPrecision: json["decimalPrecision"] ?? 2,
    );
  }
}
