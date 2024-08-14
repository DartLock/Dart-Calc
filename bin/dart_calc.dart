import 'package:dart_calc/dart_calc.dart' as dart_calc;
import 'package:dart_calc/string_format.dart';
import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  print('Hello world: ${dart_calc.calculate()}!');

  while(true) {
    print("Enter math expression OR 'q' for exit");

    final input = stdin.readLineSync();

    if (input == 'q') break;

    final expression = input!.replaceAll(new RegExp(r'\s'), '');
    final expression_elements = expression!.trim().split(new RegExp(r"b*"));

    var result;

    try {
      double first_element = double.parse(expression_elements.first);
      double second_element = double.parse(expression_elements.last);
      final operand = expression_elements[1];

      result = switch(operand) {
        "-" => "$input = ${format(first_element - second_element)}",
        "+" => "$input = ${format(first_element + second_element)}",
        "*" => "$input = ${format(first_element * second_element)}",
        "/" => "$input = ${format(first_element / second_element)}",
        "%" => "$input = ${format(first_element % second_element)}",
        "^" => "$input = ${format(pow(first_element, second_element).toDouble())}",
        _ => "Unknown operation"
      };
    } on Exception catch (e) {
      result = "Wrong expression: $e";
    }

    print(result);
  }
}
