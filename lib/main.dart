import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyek_akhir_dicoding/home_screen.dart';
import 'package:proyek_akhir_dicoding/play_screen.dart';
import 'package:proyek_akhir_dicoding/highscore_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyek Akhir Dicoding',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xff222222),
        fontFamily: 'Oxygen',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/play': (context) => const PlayScreen(),
        '/highscore': (context) => const HighscoreScreen(),
      },
    );
  }
}
