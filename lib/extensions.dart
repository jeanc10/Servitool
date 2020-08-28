import 'package:intl/intl.dart';

extension NumberParsing on DateTime {
  String plainText() {
    return DateFormat('dd/MM/yyyy', 'es').format(this);
  }
}