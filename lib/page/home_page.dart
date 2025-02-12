import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progetto_finale_flutter_advanced/bloc/shopping_cart_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingCartBloc>(context).add(ShoppingCartBlocEventInit());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      body: Stack(
        children: [stackProducts(), floatingActionButton()],
      ),
    );
  }

  AppBar appBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "Luigi's",
              style: TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            Text(
              "Spedizione gratuita per ordini > 50\$",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600),
            ),
          ],
        ),
      );

  Widget stackProducts() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final products = (state as ShoppingCartBlocStateLoaded).products;
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 95),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 5),
            itemCount: products.length,
            itemBuilder: (contex, index) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(products[index].imageUrl),
                            fit: BoxFit.cover)),
                  )),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    products[index].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${products[index].price.toStringAsFixed(2)} \$",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<ShoppingCartBloc>(context).add(
                          ShoppingCartBlocEvenProductToggle(products[index]));
                    },
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.black12)),
                    child: Text(
                        products[index].inShoppingCart ? 'Rimuovi' : 'Aggiungi',
                        style: TextStyle(
                            color: products[index].inShoppingCart
                                ? Colors.red
                                : Colors.black)),
                  )
                ],
              ),
            ),
          );
        }
      });

  Widget floatingActionButton() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
        builder: (context, state) {
          if (state is ShoppingCartBlocStateLoading) {
            return const SizedBox();
          } else {
            final products = (state as ShoppingCartBlocStateLoaded).products;
            final productsShoppingCart =
                products.where((it) => it.inShoppingCart).toList();

            if (productsShoppingCart.isEmpty) {
              return const SizedBox();
            } else {
              return Positioned(
                left: 16,
                right: 16,
                bottom: 32,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  height: 50,
                  elevation: 0,
                  minWidth: double.infinity,
                  color: Colors.yellow.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                      "Completa Acquisto (${productsShoppingCart.length})"),
                ),
              );
            }
          }
        },
      );
}
