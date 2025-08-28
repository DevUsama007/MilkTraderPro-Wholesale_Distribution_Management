import 'package:flutter/foundation.dart';
import 'package:khata_app/app/utils/calender_utils.dart';

class HomepageViewModel extends ChangeNotifier {
  final List<int> _yearList = [
    2025,
    2026,
    2027,
    2028,
    2030,
    2031,
    2032,
    2033,
    2034,
    2035,
    2036
  ];
  final List<String> _monthNames = [
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
    'December',
  ];
  int _selectYear = CalenderUtils.getCurrentYear();
  int get selectYear => _selectYear;
  List<String> get monthName => _monthNames;
  List<int> get yearList => _yearList;
  getTheyear() {
    _selectYear = CalenderUtils.getCurrentYear();
    ChangeNotifier();
  }

  setTheYear(int year) {
    _selectYear = year;
  }
}
