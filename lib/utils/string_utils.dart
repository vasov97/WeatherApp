import 'package:intl/intl.dart';

String parseDate(String date) {
  DateTime dateTime = DateTime.parse(date.toString());
  String formattedDate = DateFormat('dd MMM').format(dateTime);
  return formattedDate;
}
