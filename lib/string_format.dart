String format(double calc_result) {
  if ((calc_result % 1) == 0) return calc_result.truncate().toString();

  return calc_result.toString();
}