import 'package:flutter/material.dart';
import 'package:khata_app/app/utils/app_routes/routes_name.dart';
import 'package:khata_app/app/view/chk_view_screen.dart';
import 'package:khata_app/app/view/home_screen_view.dart';
import 'package:khata_app/app/view/record_screen.dart';
import 'package:khata_app/app/view/splashScreen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    print("Navigating to: ${settings.name}"); // Debug log
    switch (settings.name) {
      case RoutesName.homescreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreenView(),
        );
      case RoutesName.RecordScreen:
        return MaterialPageRoute(
          builder: (context) {
            return RecordScreen(
              month: '',
              year: 0,
              chkName: '',
            );
          },
        );
      case RoutesName.ChkViewScreen:
        return MaterialPageRoute(
          builder: (context) {
            return ChkViewScreen(
              selectedMonth: '',
              selectedYear: 0,
            );
          },
        );
      case RoutesName.splashscreen:
        return MaterialPageRoute(
          builder: (context) {
            return Splashscreen();
          },
        );
      case RoutesName.ChkViewScreen:
        return MaterialPageRoute(
          builder: (context) {
            return ChkViewScreen(
              selectedMonth: '',
              selectedYear: 0,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No Routes defined'),
              ),
            );
          },
        );
    }
  }
}
