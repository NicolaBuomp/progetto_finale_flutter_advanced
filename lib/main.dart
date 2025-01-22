import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progetto_finale_flutter_advanced/bloc/shopping_cart_bloc.dart';
import 'package:progetto_finale_flutter_advanced/page/checkout_page.dart';
import 'package:progetto_finale_flutter_advanced/page/home_page.dart';

void main() {
  runApp(MultiBlocProvider(providers: [BlocProvider(create: (_) => ShoppingCartBloc())], child: MyApp()));
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
