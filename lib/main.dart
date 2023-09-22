import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:o_kay_customer/constants/colors.dart';
import 'package:o_kay_customer/helpers/dismiss_keyboard.dart';
import 'package:o_kay_customer/providers/authentication_provider.dart';
import 'package:o_kay_customer/providers/cart_provider.dart';
import 'package:o_kay_customer/providers/internet_provider.dart';
import 'package:o_kay_customer/providers/location_provider.dart';
import 'package:o_kay_customer/providers/order_provider.dart';
import 'package:o_kay_customer/router.dart';
import 'package:o_kay_customer/splash_screen/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Initialize Firebase Analytics
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: DismissKeyboard(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'o_kay_customer', // Updated app title with title case
          theme: ThemeData(
            colorScheme: scheme,
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            unselectedWidgetColor: Color.fromARGB(255, 16, 2, 214),
          ),
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('ar', 'SA'),
          ],
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const SplashScreen(),
        ),
      ),
    ),
  );
}
