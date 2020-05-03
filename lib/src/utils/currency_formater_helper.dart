import 'package:intl/intl.dart';
import 'dart:math';

class CurrencyFormater {
  static String usdFormat(double price) {
    final usdFormatter = new NumberFormat("\$#,##0.00", "en_US");
    return usdFormatter.format(price);
  }

  static String withSuffix(double count) {
    String currencyUnits = "KMBTQQ";
    if (count <= 1000) {
      return "" + count.toString();
    }
    int exp = (log(count).toInt() / log(1000)).toInt();
    return (count / pow(1000, exp)).toString() + currencyUnits[exp-1];
  }
}
