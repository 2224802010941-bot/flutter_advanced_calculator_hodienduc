class CalculationHistory {
  final String expression;
  final String result;

  CalculationHistory(this.expression, this.result);

  Map<String, dynamic> toJson() => {
    "expression": expression,
    "result": result,
  };

  factory CalculationHistory.fromJson(Map<String, dynamic> json) {
    return CalculationHistory(
      json["expression"],
      json["result"],
    );
  }
}
