import 'dart:math';

typedef OperationProcessing = String Function();

class Combiner {
  static late String result;
  static final roundBrakesPattern = new RegExp(r"\(-\d+\)|\((-?\d+\.\d+?)\)", caseSensitive: false);
  static final numericPattern = new RegExp(r"(-?\d+\.\d+?)|(-?\d+?)");
  static final operatorPattern = new RegExp(r"\s[\-\+\/\*]\s");
  static final addPattern = new RegExp(r"(-?\d+(\.\d+)?) \+ (-?\d+(\.\d+)?)", caseSensitive: false);
  static final subPattern = new RegExp(r"(-?\d+(\.\d+)?) - (-?\d+(\.\d+)?)", caseSensitive: false);

  static final divideSinglePattern = new RegExp(r"(\(?-?\d+\.?\d+?\)?) [\*\/] (\(?-?\d+\.?\d+?\)?)", caseSensitive: false);
  static final multipleSinglePattern = new RegExp(r"(\(?-?\d+\.?\d+?\)?) [\*\/] (\(?-?\d+\.?\d+?\)?)", caseSensitive: false);

  static final dividePattern = new RegExp(r"(-?\d+(\.\d+)?) \/ (-?\d+(\.\d+)?)", caseSensitive: false);
  static final multiplePattern = new RegExp(r"(-?\d+(\.\d+)?) \* (-?\d+(\.\d+)?)", caseSensitive: false);

  static void calculate(String sourceExpression) {
    while(true) {
      sourceExpression = operationProcessing(multiplePattern, sourceExpression);
      sourceExpression = operationProcessing(dividePattern, sourceExpression);
      sourceExpression = operationProcessing(divideSinglePattern, sourceExpression);
      sourceExpression = operationProcessing(multipleSinglePattern, sourceExpression);
      sourceExpression = operationProcessing(subPattern, sourceExpression);
      sourceExpression = operationProcessing(addPattern, sourceExpression);

      try {
        result = (double.parse(sourceExpression)).toString();
        break;
      } on Exception catch (e) {
        result = sourceExpression;
        continue;
      }
    }
  }

  static String operationProcessing(RegExp pattern, String expression) {
    expression = expression.replaceAllMapped(pattern, Combiner.computeProcessing);

    return removeRoundBrakes(expression);
  }

  static String computeProcessing(Match match) {
    Iterable<Match> numbersMatches = numericPattern.allMatches(match[0]!, 0);
    final first = numbersMatches.elementAt(0)[0];
    final second = numbersMatches.elementAt(1)[0];
    final operator = operatorPattern.allMatches(match[0]!, 0).elementAt(0)[0]!.trim();

    return Combiner.compute(first, second, operator).toString();
  }

  static double compute(first, second, operator) {
    double first_element = double.parse(first);
    double second_element = double.parse(second);

    final result = switch(operator) {
      "-" => first_element - second_element,
      "+" => first_element + second_element,
      "*" => first_element * second_element,
      "/" => first_element / second_element,
      "%" => first_element % second_element,
      "^" => pow(first_element, second_element).toDouble(),
      _ => throw "Unknown operation"
    };

    return result;
  }

  static String removeRoundBrakes(String expression) {
    expression = expression.replaceAllMapped(roundBrakesPattern, _removeRoundBrakes);

    return expression;
  }

  static String _removeRoundBrakes(Match match) {
    var number = match[0]!;
    number = number.replaceAll(r"(", "");
    number = number.replaceAll(r")", "");

    return number;
  }
}
