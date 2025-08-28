import 'package:intl/intl.dart';

class CalenderUtils {
  static int getDaysInCurrentMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0).day;
  }

  static String getCurrentMonthName() {
    return DateFormat('MMMM').format(DateTime.now());
  }

  static int getCurrentYear() {
    return DateTime.now().year;
  }

  static int getCurrentDate() {
    return DateTime.now().day;
  }

  static getMonthName(int monthNumber) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    if (monthNumber < 1 || monthNumber > 12) {
      throw RangeError('Month number must be between 1 and 12');
    }

    return months[monthNumber - 1];
  }

  static bool containsAlphabet(String input) {
    return RegExp(r'[a-zA-Z]').hasMatch(input);
  }
}
