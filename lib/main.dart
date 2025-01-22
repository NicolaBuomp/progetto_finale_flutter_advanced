import 'package:flutter/material.dart';
import 'package:progetto_finale_flutter_advanced/page/checkout_page.dart';
import 'package:progetto_finale_flutter_advanced/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/checkout': (_) => const CheckoutPage(),
      },
    );
  }
}
