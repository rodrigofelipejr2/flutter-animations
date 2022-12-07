import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/page/home_page.dart';
import 'package:flutter_application_success_page/page/splash_page.dart';

import 'page/success_2/success_2_page.dart';
import 'utils/constants.dart';
import 'utils/material_color_generator.dart';
import 'page/success_1/success_1_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: Constants.primary),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/success1': (context) => const Success1Page(),
        '/success2': (context) => const Success2Page(),
      },
    );
  }
}
