import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khata_app/app/utils/app_routes/routes.dart';
import 'package:khata_app/app/utils/app_routes/routes_name.dart';
import 'package:khata_app/app/view_model/chk_view_model.dart';
import 'package:khata_app/app/view_model/homepage_view_model.dart';
import 'package:khata_app/firebase_options.dart';
import 'package:provider/provider.dart';

import 'app/view_model/recordScreen_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomepageViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChkViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecordscreenViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.generateRoutes,
        initialRoute: RoutesName.splashscreen,
      ),
    );
  }
}
