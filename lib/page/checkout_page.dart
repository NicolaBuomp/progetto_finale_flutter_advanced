import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/shopping_cart_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingCartBloc, ShoppingCartBlocState>(
      listener: (context, state) {
        final products = (state as ShoppingCartBlocStateLoaded)
            .products
            .where((it) => it.inShoppingCart)
            .toList();

        if (products.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: appBar(),
        body: CustomScrollView(
          slivers: [sectionProductList(), sectionCostRecap()],
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      );

  Widget sectionProductList() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final products = (state as ShoppingCartBlocStateLoaded)
              .products
              .where((it) => it.inShoppingCart)
              .toList();
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(products[index].imageUrl),
                  ),
                  title: Text(
                    products[index].name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${products[index].price.toStringAsFixed(2)} \$",
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        BlocProvider.of<ShoppingCartBloc>(context).add(
                            ShoppingCartBlocEvenProductToggle(products[index]));
                      },
                      icon: const Icon(Icons.remove_circle_outline)),
                ),
              ),
              childCount: products.length,
            ),
          );
        }
      });

  Widget sectionCostRecap() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final products = (state as ShoppingCartBlocStateLoaded)
              .products
              .where((it) => it.inShoppingCart)
              .toList();
          final subtotal = products.map((it) => it.price).sum;
          final tax = subtotal * 0.2;
          final total = subtotal + tax;
          return SliverToBoxAdapter(
            child: Column(
              children: [
                CheckoutRow(
                  title: 'Sottototale',
                  value: subtotal,
                ),
                CheckoutRow(
                  title: 'Tasse',
                  value: tax,
                ),
                ListTile(
                  dense: true,
                  title: const Text(
                    'Totale',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '${total.toStringAsFixed(2)} \$',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MaterialButton(
                    onPressed: () {},
                    height: 50,
                    elevation: 0,
                    minWidth: double.infinity,
                    color: Colors.yellow.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text("Acquista"),
                  ),
                ),
              ],
            ),
          );
        }
      });
}

class CheckoutRow extends StatelessWidget {
  final String title;
  final double value;
  const CheckoutRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
      trailing: Text(
        '${value.toStringAsFixed(2)}\$',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
