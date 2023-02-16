import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/login/home_page.dart';
import 'provider/google_sign_in.dart';
import 'themes/form_input_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* Transparent StatusBar */
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: FormInputTheme().theme(), // Form Input Theme (Currency Loan)
      ),
      debugShowCheckedModeBanner: false, // Hide debug banner

      // Polish language
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('pl'),
      ],
      home: const HomePage(),
    ),
  );
}
