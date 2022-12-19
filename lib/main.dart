import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/page/home_page.dart';
import 'package:flutter_application_success_page/page/splash_page.dart';
import 'package:flutter_application_success_page/page/success_1/success_1_page.dart';
import 'package:flutter_application_success_page/page/success_2/success_2_page.dart';
import 'package:flutter_application_success_page/page/success_3/success_3_page.dart';
import 'package:flutter_application_success_page/utils/constants.dart';
import 'package:flutter_application_success_page/utils/material_color_generator.dart';

import 'page/success_4/success_4_page.dart';
import 'page/unknown/unknown_page.dart';

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
      onGenerateRoute: (settings) {
        late PageRouteBuilder pageRouteBuilder;

        if (settings.name == "/") {
          pageRouteBuilder = PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const SplashPage(),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          );
        } else if (settings.name == "/home") {
          pageRouteBuilder = PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomePage(),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          );
        } else if (settings.name == "/success1") {
          pageRouteBuilder = PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const Success1Page(),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          );
        } else if (settings.name == "/success2") {
          pageRouteBuilder = PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const Success2Page(),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          );
        } else if (settings.name == "/success3") {
          pageRouteBuilder = PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const Success3Page(),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          );
        } else if (settings.name == "/success4") {
          pageRouteBuilder = PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const Success4Page(),
            transitionsBuilder: (context, animation, anotherAnimation, c) => SlideTransition(
              position: Tween(begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
                  .animate(CurvedAnimation(curve: Curves.easeOutSine, parent: animation)),
              child: c,
            ),

            //  transitionDuration: Duration(milliseconds: 2000),
            //           transitionsBuilder:
            //               (context, animation, anotherAnimation, child) {
            //             animation = CurvedAnimation(
            //                 curve: curveList[index], parent: animation);
            //             return  SlideTransition(
            //                 position: Tween(
            //                         begin: Offset(1.0, 0.0),
            //                         end: Offset(0.0, 0.0))
            //                     .animate(animation),
            //                 child: child,
            //             );
            //           }));
          );
        } else {
          return MaterialPageRoute(builder: (_) => const UnknownPage());
        }

        return pageRouteBuilder;
      },
    );
  }
}
