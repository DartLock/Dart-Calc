import 'package:dart_calc/combiner.dart';

void main() {
  String sourceExpression = "- 5 + (3 + 2 - 3 * 6 + 2) / 3 + (1 * 2 + (6 + 8) * 4)";
  print("source expression : ${sourceExpression}");


  //while(true) {
  // print("Enter math expression OR 'q' for exit");
  //
  // final input = stdin.readLineSync();
  //
  // if (input == 'q') break;

  // sourceExpression = sourceExpression!.replaceAll(new RegExp(r'\s'), '');
  Combiner.calculate(sourceExpression);
  //}

  print(Combiner.result);
}
