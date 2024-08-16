// typedef MapFunction = String Function(String);

const default_expression = "5 * (4 + 7) - 3 * 6 + 2";
const hight_expression = "- 5 + (3 + 2 - 3 * 6 + 2) / 3 + (1 + 2 + (6 + 8) / 4)";
const lite_expression = "5 - 3 * 6 + 2";
const higth_pattern = r"(\d [\*|\/] \d)|(\(.+\))";

String mapFunc(String el) {
  el = el;

  return el;
}

class Parser {
  static void reg_parser({String math_string = default_expression}) {
    List splitted = math_string.split(new RegExp(higth_pattern));

    print("reg_parser splitted: $splitted");
  }

  static String parse({ String expression = hight_expression }) {
    print("entry expression: $expression");

    final splitted_expression = expression.replaceAll(new RegExp(r'\s'), '').split('');

    print("splitted_expression: $splitted_expression");

    // parse(expression: expression);

    final result = splitted_expression.map((el) {

    });

    print("map result: $result");

    return "";
  }
}



void main() {
  Parser.parse();
  // Parser.reg_parser();
}