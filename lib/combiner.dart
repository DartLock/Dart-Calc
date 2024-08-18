import 'dart:math';
import 'dart:io';

typedef OperationProcessing = String Function();

class Combiner {
  static late String result;
  static int match_count = 1;

  static final roundBrakesPattern = new RegExp(r"\(-\d+\)|\((-?\d+\.\d+?)\)", caseSensitive: false);
  static final numericPattern = new RegExp(r"(-?\d+\.\d+?)|(-?\d+?)");
  static final operatorPattern = new RegExp(r"\s[\-\+\/\*]\s");
  static final addPattern = new RegExp(r"(-?\d+(\.\d+)?) \+ (-?\d+(\.\d+)?)", caseSensitive: false);
  static final subPattern = new RegExp(r"(-?\d+(\.\d+)?) - (-?\d+(\.\d+)?)", caseSensitive: false);

  static final divideSinglePattern = new RegExp(r"(\(?-?\d+\.?\d+?\)?) [\*\/] (\(?-?\d+\.?\d+?\)?)", caseSensitive: false);
  static final multipleSinglePattern = new RegExp(r"(\(?-?\d+\.?\d+?\)?) [\*\/] (\(?-?\d+\.?\d+?\)?)", caseSensitive: false);

  static final dividePattern = new RegExp(r"(-?\d+(\.\d+)?) \/ (-?\d+(\.\d+)?)", caseSensitive: false);
  static final multiplePattern = new RegExp(r"(-?\d+(\.\d+)?) \* (-?\d+(\.\d+)?)", caseSensitive: false);

  static String negativeFormat(String expression) {
    List splittedExpression = expression.split(r"");

    return expression;
  }

  static String _negativeFormat(Match match) {
    print("_negativeFormat match[0]: ${match[0]}");

    Iterable<Match> numbersMatches = numericPattern.allMatches(match[0]!, 0);
    final first = numbersMatches.elementAt(0)[0];
    final second = numbersMatches.elementAt(1)[0];

    print("first: ${first}");
    print("second: ${second}");

    final operator = operatorPattern.allMatches(match[0]!, 0).elementAt(0)[0]!.trim();

    return Combiner.compute(first, second, operator).toString();
  }

  static String? calculate(String sourceExpression) {
    while(true) {
      print("");
      print("Enter 'n' for next or 'q' for exit");
      print("Current Expression: $sourceExpression");

      final input = stdin.readLineSync();

      if (input.toString().toLowerCase() == 'q') break;

      sourceExpression = operationProcessing(multiplePattern, sourceExpression);
      sourceExpression = operationProcessing(dividePattern, sourceExpression);
      sourceExpression = operationProcessing(divideSinglePattern, sourceExpression);
      sourceExpression = operationProcessing(multipleSinglePattern, sourceExpression);
      sourceExpression = operationProcessing(subPattern, sourceExpression);
      sourceExpression = operationProcessing(addPattern, sourceExpression);

      sourceExpression = negativeFormat(sourceExpression);

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
    print("");
    print("operationProcessing pattern: ${pattern.toString()}");

    match_count = 1;
    expression = expression.replaceAllMapped(pattern, Combiner.computeProcessing);

    print("operationProcessing ${pattern.toString()} END");
    print("expression: ${expression}");

    return removeRoundBrakes(expression);
  }

  static String computeProcessing(Match match) {
    print("${match_count}. computeProcessing match[0]: ${match[0]}");
    match_count++;

    Iterable<Match> numbersMatches = numericPattern.allMatches(match[0]!, 0);
    final first = numbersMatches.elementAt(0)[0];
    final second = numbersMatches.elementAt(1)[0];

    print("first: ${first}");
    print("second: ${second}");

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
    print("removeRoundBrakes 1: $expression");
    expression = expression.replaceAllMapped(roundBrakesPattern, _removeRoundBrakes);
    print("removeRoundBrakes 2: $expression");

    return expression;
  }

  static String _removeRoundBrakes(Match match) {
    print("_removeRoundBrakes match[0]: ${match[0]}");

    var number = match[0]!;

    number = number.replaceAll(r"(", "");
    number = number.replaceAll(r")", "");

    print("_removeRoundBrakes replaced: $number");

    return number;
  }
}
