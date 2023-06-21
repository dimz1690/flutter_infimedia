import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latihan_1/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  // Sebelum menggunakan fiture firebase, silahkan lengkapi file konfigurasi
  // firebase_options dengan benar

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('id', ''), // Indonesia
      ],
      // supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.ubuntuTextTheme(textTheme),
      ),
      initialRoute: '/home',
      routes: {'/home': (context) => const HomePage()},
    );
  }
}
