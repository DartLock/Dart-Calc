import 'package:dart_calc/combiner.dart';
import 'dart:io';

void main() {
  String? defaultExpression = "-5 + (3 + 2 - 3 * 6 + 2) / 3 + (1 * 2 + (6 + 8) * 4)";

  print("Правила ввода выражения:");
  print("1. Между операторами и операндом должны быть пробелмы. Пример: 3 + 4");
  print("2. Перед скобками снаружи должны быть пробелмы. Пример: 2 + (3 + 4) - 1");
  print("3. Отрицательные числа указываются слитно со знаком минус. Пример: -1");
  print("Пример правильно написанного выражения : ${defaultExpression}");

  while(true) {
    print("Enter math expression OR 'q' for exit");

    final input = stdin.readLineSync();

    if (input == 'q') break;

    if (input.toString().length > 0) defaultExpression = input;

    Combiner.calculate(defaultExpression!);

    print("expression result: ${Combiner.result}");
  }
}
