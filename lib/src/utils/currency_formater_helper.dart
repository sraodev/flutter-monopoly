import 'package:intl/intl.dart';

class CurrencyFormater {
  static String usdFormat(double price) {
    final usdFormatter = new NumberFormat("\$#,##0.00", "en_US");
    return usdFormatter.format(price);
  }
}
